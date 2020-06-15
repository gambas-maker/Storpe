const selectOutcome = () => {
  const selects = document.querySelectorAll(".square");
  selects.forEach((outcome)=>{
    outcome.addEventListener("click",(event) =>{
      event.currentTarget.classList.toggle('active')
      const result = event.currentTarget.dataset.outcome;
      console.log(result);
      const id = event.currentTarget.parentNode.dataset.id;
      console.log(id);
      const player = document.getElementById('season_player').value;
      const url = 'store_outcome?result='+result+'&match='+id+'&player='+player
      fetch(url)
        .then(response => response.json())
        .then((data) => {
      console.log(data);
      });
    });
  });
}

const validePanier = () => {
  const panier = document.getElementById('panier');
  panier.addEventListener("click", (event) =>{
    console.log("click")
    const player = document.getElementById('season_player').value;
    fetch('confirm_pending?player='+player)
    .then(response => response.json())
    .then((data) => {
    console.log(data);
    });
  })
}
export { selectOutcome, validePanier };


