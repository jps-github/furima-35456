function priceCalc(){
  const priceInput = document.getElementById("item-price")
  const taxDisplay = document.getElementById("add-tax-price")
  const profitDisplay = document.getElementById("profit")

  priceInput.addEventListener("input", () => {
    let input = priceInput.value
    let tax = Math.round(input* 0.1)
    let profit = input - tax
    taxDisplay.innerHTML = tax
    profitDisplay.innerHTML = profit
  })
}

window.addEventListener('load', priceCalc)