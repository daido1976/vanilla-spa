import { greet } from "./lib.js";

const mount = () => {
  document.getElementById("download").onclick = async () => {
    const res = await fetch("/download", {
      method: "GET",
    });
    const blob = await res.blob();
    const file = window.URL.createObjectURL(blob);
    window.location.assign(file);
  };

  document.getElementById("redirect").onclick = async () => {
    await fetch("/redirect", {
      method: "GET",
    });
  };

  document.getElementById("runjs").onclick = () => {
    console.log(greet());
  };
};

window.addEventListener("load", () => {
  mount();
});
