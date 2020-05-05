const indicateTurn = () => {
  const headers = document.querySelector('#table-headers');
  const rolls = document.querySelector('#rolls-headers').querySelectorAll('th');
  const [head, ...tail] = rolls
  tail.sort(function(a, b) {
      return parseInt(a.innerText, 10) - parseInt(b.innerText, 10);
  });
  const participationId = tail[0].dataset.participationRollId
  const newTurn = document.querySelector(`th[data-participation-id='${participationId}']`)
  newTurn.classList.add('current-turn')
};



export { indicateTurn };
