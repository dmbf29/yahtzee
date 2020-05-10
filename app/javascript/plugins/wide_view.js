const initWideView = () => {
  const wideViewBtn = document.getElementById('wide-view-btn')
  const leftColumn = document.getElementById('left-column')
  const rightColumn = document.getElementById('right-column')
  wideViewBtn.addEventListener('click', (event) => {
    leftColumn.classList.toggle('col-sm-8');
    leftColumn.classList.toggle('col-md-8');
    leftColumn.classList.toggle('col-lg-6');
    rightColumn.classList.toggle('col-sm-4');
    rightColumn.classList.toggle('col-md-4');
  });
}

export { initWideView };
