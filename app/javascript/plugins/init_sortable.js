import Sortable from 'sortablejs';
import { fetchWithToken } from "../utils/fetch_with_token";

const initSortable = () => {
  const list = document.querySelector('#table-headers');
  Sortable.create(list, {
    filter: "#first-header",
    ghostClass: "ghost",
    animation: 150,
    onEnd: (event) => {
      const participationId = event.item.dataset.participationId // need this??
      const headerElements = event.target.querySelectorAll('th')
      const gameId = event.target.dataset.gameId
      let index = 0
      const idCollection = []
      headerElements.forEach((th) => {
        idCollection.push(th.dataset.participationId);
      })
      // send patch to participation to update order with newIndex
      fetchWithToken(`/participations/order`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ participation: { ids: idCollection, }, game: {id: gameId}})
        })
          .then(response => response.json())
          .then((data) => {
            console.log(data)
          });
      // alert(`${event.oldIndex} moved to ${event.newIndex}`);
    }
  });
};



export { initSortable };
