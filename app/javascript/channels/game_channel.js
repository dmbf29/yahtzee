import consumer from "./consumer";
import { initSortable } from '../plugins/init_sortable';
import { indicateTurn } from '../plugins/indicate_turn';

const gameContainer = document.getElementById('game');
console.log("HEY! I'M INSDIE THE CHANNEL")
if (gameContainer) {
  const id = gameContainer.dataset.gameId;
  consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
    received(data) {
      console.log(data)
      if (data.table) {
        const gameTable = document.getElementById('game-table');
        gameTable.innerHTML = data.table; // called when data is broadcast in the cable
      }
      if (data.message) {
        console.log(gameContainer)
        const submissionsContainer = document.getElementById('rolls');
        submissionsContainer.insertAdjacentHTML('afterbegin', data.message);
        // submissionsContainer.style.backgroundColor = 'yellow'
      }
      if (data.new_game) {
        // Send invite
        console.log("Hey wanna play a new game?")
        // trigger modal
        const invitationModal = document.getElementById("new-game-invitation");
        invitationModal.innerHTML = data.new_game
        const invitationBtn = document.getElementById('game-invite-btn');
        invitationBtn.click();
      }
      if (data.finished) {
        // show the play again button
        const playAgainBtn = document.getElementById('play-again-btn');
        playAgainBtn.classList.remove('d-none')
      }
      initSortable();
      indicateTurn();
      // const submissions = document.querySelectorAll('.submission');
      // const lastMessage = submissions[submissions.length - 1];
      // if (lastMessage !== undefined) {
        // lastMessage.scrollIntoView();
      // }
    },
  });
}
