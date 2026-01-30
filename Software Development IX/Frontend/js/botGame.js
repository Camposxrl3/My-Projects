(() => {
    const App = (() => {
        const htmlElements = {
            btnLogout: document.querySelector(".logout"),
            title: document.querySelector(".logo"),
            playerName: document.querySelector("#playerName"),
            passBtn: document.querySelector("#passBtn"),
            restartBtn: document.querySelector("#restartBtn"),
            host: document.querySelector("#host"),
        }

        const methods = {
            checkSession: () => {
                if(sessionStorage.getItem("username") !== null){
                    const title = htmlElements.title;
                    const host = htmlElements.host;
                    const username = sessionStorage.getItem("username");
                    methods.clean(title);
                    methods.print(title, `♜ Hashing Chess ♜ - ${username}`);
                    methods.clean(host);
                    methods.print(host, `${username}`);

                }
                else{
                    window.location.href = 'index.html';
                    alert("Debes iniciar sesión primero antes de jugar!");
                }
            },
            logOut: () => {
                sessionStorage.clear();
                window.location.href = 'index.html';
                
            },
            clean: (element) => {
                element.innerHTML = "";
            },
            print: (element, text) => {
                element.innerHTML += `${text}`;
            },
        }

        const handlers = {
            loadPage: () => {
                methods.checkSession();
            },
            closeSession: () => {
                methods.logOut();
            },
            openDialog: () => {
                htmlElements.loginDialog.showModal();
            },
            closeDialog: () => {
                htmlElements.loginDialog.close();
            },
            loginSubmit: (e) => {
                e.preventDefault();
                if (!loginForm.checkValidity()) {
                    loginForm.reportValidity();
                    return;
                }
                const email = htmlElements.loginForm.email.value;
                const password = htmlElements.loginForm.password.value;
                methods.logIn(email, password);
            }
            
        };

        return {
            init: () => {
                handlers.loadPage();
                htmlElements.btnLogout.addEventListener('click',handlers.closeSession);
            }
        }
    })();
    App.init();
})();