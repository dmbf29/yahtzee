const highlightCells = () => {
  const cursorForm = document.getElementById('cursor_place')
  let cursorValue = document.getElementById('cursor_place_id')
  const numbers = document.querySelectorAll('.numeric')
  numbers.forEach((number) => {
    number.addEventListener('focus', (event) => {
      cursorValue.value = event.currentTarget.id
      Rails.fire(cursorForm,'submit')
    });
    // number.addEventListener('blur', (event) => {
    //   cursorValue.value = ''
    //   Rails.fire(cursorForm,'submit')
    // });
  });
}

// const latestUserDate = (participation) => {
//   const dates = document.querySelectorAll()
//   new Date(Math.max.apply(null, dates.map(function(e) {
//     return new Date(e.MeasureDate);
//   })));
// }

// const startHighlights = () => {
//   const participations = document.querySelectorAll
//   // get all participations
//   // iterate over participations
//     // get all the submissions dates for each participation
//     // get the latest date
//   // get the submission of that date
//   // if submission, add the class to it
// }

export { highlightCells };
