function salesCommission(){
const priceInput = document.getElementById("item-price");
priceInput.addEventListener('input', () => {
  let fee = Math.floor(priceInput.value * 0.1);
  let profit = priceInput.value - fee;
  const feeArea = document.getElementById('add-tax-price');
  feeArea.innerHTML = `${fee}`;
  const profitArea = document.getElementById('profit');
  profitArea.innerHTML = `${profit}`;
});
};

window.addEventListener('load', salesCommission);