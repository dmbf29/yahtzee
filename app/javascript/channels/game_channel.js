import consumer from "./consumer";
import { initSortable } from '../plugins/init_sortable';
import { indicateTurn } from '../plugins/indicate_turn';
import { highlightCells } from '../plugins/highlight_cells';

const gameContainer = document.getElementById('game');
if (gameContainer) {
  const id = gameContainer.dataset.gameId;
  consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
    received(data) {
      console.log(data)
      if (data.cursor_moved) {
        if (data.cursor_place) {
          const preSelectedPlace = document.querySelector(`.participation-${data.participation_place}`)
          if (preSelectedPlace) {
            preSelectedPlace.classList.remove(`participation-${data.participation_place}`)
          }
          const cursorValue = document.getElementById(data.cursor_place);
          cursorValue.parentElement.parentElement.classList.add(`participation-${data.participation_place}`)
        } else {
          const selectedPlace = document.querySelector(`.participation-${data.participation_place}`)
          selectedPlace.classList.remove(`participation-${data.participation_place}`)
        }
      }
      if (data.table) {
        const gameTable = document.getElementById('game-table');
        gameTable.innerHTML = data.table; // called when data is broadcast in the cable
        highlightCells();
        initSortable();
        indicateTurn();
      }
      if (data.message) {
        const submissionsContainer = document.getElementById('rolls');
        submissionsContainer.insertAdjacentHTML('afterbegin', data.message);
      }
      if (data.new_game) {
        // Send invite
        // trigger modal
        const invitationModal = document.getElementById("new-game-invitation");
        invitationModal.innerHTML = data.new_game
        const invitationBtn = document.getElementById('game-invite-btn');
        invitationBtn.click();
      }
      if (data.finished) {
        // show the play again button
        const shareContainer = document.getElementById('share-group');
        shareContainer.remove();
        const playAgainBtn = document.getElementById('play-again-btn');
        playAgainBtn.classList.remove('d-none');
        playAgainBtn.parentElement.classList.add('d-flex');
        playAgainBtn.parentElement.classList.add('my-2');
        // update the leaderboard
        const leaderboardContainer = document.getElementById('leaderboard-container');
        leaderboardContainer.innerHTML = data.finished
      }
      if (data.big_boys) {
        const bigBoysContainer = document.getElementById('big-boys-container');
        bigBoysContainer.innerHTML = data.big_boys
      }
      if (data.new_player) {
        const participantsContainer = document.getElementById('participations-container');
        participantsContainer.innerHTML = data.new_player
      }
      if (data.remove_list) {
        const participantsContainer = document.getElementById('remove-modal');
        participantsContainer.innerHTML = data.remove_list
      }
      if (data.modal_close) {
        const backDrop = document.querySelector('.modal-backdrop');
        if (backDrop) { backDrop.remove(); }
        const userModal = document.getElementById(data.modal_name);
        if (userModal) { userModal.innerHTML = data.modal_close }
      }

      // const submissions = document.querySelectorAll('.submission');
      // const lastMessage = submissions[submissions.length - 1];
      // if (lastMessage !== undefined) {
        // lastMessage.scrollIntoView();
      // }
    },
  });
}
