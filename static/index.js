const mount = () => {
  document.getElementById("log").onclick = async () => {
    console.log("Hello static");
  };
};

window.addEventListener("load", () => {
  mount();
});
