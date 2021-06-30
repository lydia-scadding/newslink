const initAjaxRedirect = () => {
  document.addEventListener("ajax:error", (event) => {
    const [data, status, xhr] = event.detail;
    if (xhr.status === 401) {
      window.location.replace('/users/sign_in');
    }
  })
}

export { initAjaxRedirect };
