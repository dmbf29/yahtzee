const copy = () => {
  var copyText = document.querySelector("#share-link");
  copyText.select();
  document.execCommand("copy");
}

document.querySelector("#share-btn").addEventListener("click", copy);
