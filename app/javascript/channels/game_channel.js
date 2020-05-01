import consumer from "./consumer";

const gameContainer = document.getElementById('game');
console.log("Game Container:")
console.log(gameContainer)
console.log("    ")
if (gameContainer) {
  console.log("Game Id:")
  const id = gameContainer.dataset.gameId;
  console.log(id)
  console.log("    ")
  consumer.subscriptions.create({ channel: "GameChannel", id: id }, {
    received(data) {
      const gameTable = document.getElementById('game-table');
      gameTable.innerHTML = data; // called when data is broadcast in the cable
    },
  });
}
