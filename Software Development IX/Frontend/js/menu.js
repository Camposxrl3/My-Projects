(() => {
    const App = (() => {
        const htmlElements = {
            usernameTile: document.querySelector("#username"),
            userCoins: document.querySelector("#userCoins"),
            botCard: document.querySelector("#botCard"),
            friendCard: document.querySelector("#friendCard"),
            buyCard: document.querySelector("#buyCard"),
            withdrawCard: document.querySelector("#withdrawCard"),
            botCardBtn: document.querySelector(".close-btn"),
            hardWarning: document.querySelector("#hardWarning"),
            BotDifficulty: document.querySelector("#botDifficultyModal"),

        }

        const methods = {
            checkSession: () => {
                if(sessionStorage.getItem("username") !== null){
                    const usernameTile = htmlElements.usernameTile;
                    const userCoins = htmlElements.userCoins;
                    const username = sessionStorage.getItem("username");
                    const coins = sessionStorage.getItem("coins");
                    methods.print(usernameTile, `<p>${username}</p>`);
                    methods.print(userCoins, `<p>💰 ${coins} Monedas</p>`)
                }
                else{
                    window.location.href = 'index.html';
                    alert("Debes iniciar sesión primero antes de jugar!");
                }
            },
            closeModal: () => {
                htmlElements.BotDifficulty.classList.remove('active');
                htmlElements.hardWarning.computedStyleMap.display = 'none';

            },
            clean: (element) => {
                element.innerHTML = "";
            },
            print: (element, text) => {
                console.log(htmlElements.botCard);
                element.innerHTML += `${text}`;
            },
        }

        const handlers = {
            loadPage: () => {
                methods.checkSession();
            },
            clickListener: () => {
                window.onclick = (e) => {
                const modal = htmlElements.BotDifficulty;
                if (e.target === modal) methods.closeModal();
                };
            },
            closeSession: () => {
                methods.logOut();
            },
            openDifficulty: () => {
                htmlElements.BotDifficulty.classList.add('active');
            },
            closeDifficulty: () => {
                methods.closeModal();
            },
            openFriendGame: () => {
                window.location.href = 'friendGame.html';
            },
            openBotGame: () => {
                window.location.href = 'botGame.html';
            },
            openBuyMenu: () => {
                window.location.href = 'monedas.html';
            },
            openWithdraw: () => {
                window.location.href = 'retiro.html';
            },
            

            
        };

        return {
            init: () => {
                handlers.loadPage();
                handlers.clickListener();
                htmlElements.botCard.addEventListener('click', handlers.openBotGame);
                htmlElements.friendCard.addEventListener('click', handlers.openFriendGame);
                htmlElements.buyCard.addEventListener('click', handlers.openBuyMenu);
                htmlElements.withdrawCard.addEventListener('click', handlers.openWithdraw);
            }
        }
    })();
    App.init();
})();