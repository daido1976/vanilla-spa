const handleSubmit = async () => {
  const comment = document.querySelector("input#comment").value;
  const data = {
    comment,
  };
  const res = await fetch("/api/posts", {
    method: "POST",
    headers: {
      "Content-Type": "application/json;",
    },
    body: JSON.stringify(data),
  });
  const responseData = await res.json();
  const responseElement = document.getElementById("api-call-result");
  responseElement.innerText = JSON.stringify(responseData);

  // Delete input value
  document.querySelector("input#comment").value = "";
};

const handleLogin = async () => {
  const res = await fetch("/login/hoge", {
    mode: "cors",
    credentials: "include",
  });
  const responseData = await res.text();
  console.log(responseData);
};
