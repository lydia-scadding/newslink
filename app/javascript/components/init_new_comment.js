const clearFormErrors = (form) => {
  const errorsDiv = form.querySelector(".invalid-feedback");
  if (errorsDiv) {
    errorsDiv.style.display = 'none';
    const formInput = form.querySelector("#comment_body");
    formInput.classList.remove('is-invalid');
  }
}

const clearFormInput = (form) => {
  form.querySelector("#comment_body").value = "";
}

const clearPrevHighlight = () => {
  document.querySelectorAll(".comment-card").forEach((comment) => {
    comment.classList.remove("highlight");
  })
}

const highlightNewComment = () => {
  const commentsDiv = document.getElementById("comments");
  commentsDiv.firstElementChild.classList.add("highlight");
}

const initNewComment = () => {
    const form = document.getElementById("new_comment");
    if (form) {
      form.addEventListener("ajax:success", (event) => {
        clearFormErrors(form);
        clearFormInput(form);
        clearPrevHighlight();
        highlightNewComment();
      });
    }
}

export { initNewComment };
