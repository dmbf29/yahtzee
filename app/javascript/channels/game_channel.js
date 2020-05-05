import consumer from "./consumer";
import { initSortable } from '../plugins/init_sortable';

const gameContainer = document.getElementById('game');
if (gameContainer) {
  const id = gameContainer.dataset.gameId;
  consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
    received(data) {
      const submissionsContainer = document.getElementById('rolls');
      console.log(data)
      const gameTable = document.getElementById('game-table');
      gameTable.innerHTML = data.table; // called when data is broadcast in the cable
      if (data.message) {
        submissionsContainer.insertAdjacentHTML('beforeend', data.message);
        // submissionsContainer.style.backgroundColor = 'yellow'
      }
      initSortable();
      const submissions = document.querySelectorAll('.submission');
      const lastMessage = submissions[submissions.length - 1];
      if (lastMessage !== undefined) {
        lastMessage.scrollIntoView();
      }
    },
  });
}
