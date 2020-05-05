const indicateTurn = () => {
  const headers = document.querySelector('#table-headers');
  const rolls = document.querySelector('#rolls-headers').querySelectorAll('th');
  const [head, ...tail] = rolls
  tail.sort(function(a, b) {
      return parseInt(a.innerText, 10) - parseInt(b.innerText, 10);
  });
  const participationId = tail[0].dataset.participationRollId
  const newTurn = document.querySelector(`th[data-participation-id='${participationId}']`)
  newTurn.classList.add('current-turn-border')
  // Sortable.create(list, {
  //   ghostClass: "ghost",
  //   animation: 150,
  //   onEnd: (event) => {
  //     const participationId = event.item.dataset.participationId // need this??
  //     const headerElements = event.target.querySelectorAll('th')
  //     const gameId = event.target.dataset.gameId
  //     let index = 0
  //     const idCollection = []
  //     headerElements.forEach((th) => {
  //       if (index !== 0) {
  //         idCollection.push(th.dataset.participationId);
  //       }
  //       index ++;
  //     })
  //     console.log()
  //     // send patch to participation to update order with newIndex
  //     fetchWithToken(`/participations/order`, {
  //         method: "PATCH",
  //         headers: {
  //           "Content-Type": "application/json"
  //         },
  //         body: JSON.stringify({ participation: { ids: idCollection, }, game: {id: gameId}})
  //       })
  //         .then(response => response.json())
  //         .then((data) => {
  //           console.log(data)
  //         });
  //     // alert(`${event.oldIndex} moved to ${event.newIndex}`);
  //   }
  // });
};



export { indicateTurn };
