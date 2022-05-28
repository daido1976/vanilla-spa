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

import { greet } from "./lib.js";

document.getElementById("runjs").onclick = () => {
  console.log(greet());
};
