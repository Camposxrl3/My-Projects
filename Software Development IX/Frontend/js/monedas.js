(() => {
    const App = (() => {
        const htmlElements = {
            option1: document.querySelector("#option1"),
            option2: document.querySelector("#option2"),
            option3: document.querySelector("#option3"),
            option4: document.querySelector("#option4"),
        }

        const methods = {
            checkSession: () => {
                if(sessionStorage.getItem("username") === null){
                    window.location.href = 'index.html';
                    alert("Debes iniciar sesión primero!");
                }
            },
            async onCreateCheckoutSession(coins, price) {
                const email = sessionStorage.getItem("email");
                const response = await fetch('http://localhost:3000/api/v1/create-checkout-session', {
                    method: 'POST',
                    body: JSON.stringify({ monedas: coins, price: price, correo: email}),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                const data = await response.json();
                window.location.href = data.url;
            }
        }

        const handlers = {
            loadPage: () => {
                methods.checkSession();
            },
            buyOption1: () => {
                const coins = 200;
                const price = 0.99;
                methods.onCreateCheckoutSession(coins, price);
            },
            buyOption2: () => {
                const coins = 1000;
                const price = 4.99;
                methods.onCreateCheckoutSession(coins, price);
            },
            buyOption3: () => {
                const coins = 3000;
                const price = 19.99;
                methods.onCreateCheckoutSession(coins, price);
            },
            buyOption4: () => {
                const coins = 8000;
                const price = 49.99;
                methods.onCreateCheckoutSession(coins, price);
            },
        };

        return {
            init: () => {
                handlers.loadPage();
                htmlElements.option1.addEventListener('click',handlers.buyOption1);
                htmlElements.option2.addEventListener('click',handlers.buyOption2);
                htmlElements.option3.addEventListener('click',handlers.buyOption3);
                htmlElements.option4.addEventListener('click',handlers.buyOption4);

            }
        }
    })();
    App.init();
})();