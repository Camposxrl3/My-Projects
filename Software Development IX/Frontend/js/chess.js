(() => {
  const ChessGame = (() => {
    const htmlElements = {
      board: document.querySelector("#chess-board"),
      gameStatus: document.querySelector("#game-status"),
      capturedWhite: document.querySelector("#capturedByPlayer1"),
      capturedBlack: document.querySelector("#capturedByPlayer2"),
      passBtn: document.querySelector("#passBtn"),
      restartBtn: document.querySelector("#restartBtn"),
    };

    const letters = ["a", "b", "c", "d", "e", "f", "g", "h"];
    const initialPositions = {
      a8: "♜", b8: "♞", c8: "♝", d8: "♛", e8: "♚", f8: "♝", g8: "♞", h8: "♜",
      a7: "♟", b7: "♟", c7: "♟", d7: "♟", e7: "♟", f7: "♟", g7: "♟", h7: "♟",
      a2: "♙", b2: "♙", c2: "♙", d2: "♙", e2: "♙", f2: "♙", g2: "♙", h2: "♙",
      a1: "♖", b1: "♘", c1: "♗", d1: "♕", e1: "♔", f1: "♗", g1: "♘", h1: "♖"
    };

    let selectedSquare = null;
    let isWhiteTurn = true;
    let gameOver = false;

    const utils = {
      isPieceWhite: piece => ["♙", "♖", "♘", "♗", "♕", "♔"].includes(piece),
      isPieceBlack: piece => ["♟", "♜", "♞", "♝", "♛", "♚"].includes(piece),
      clearHighlights: () => {
        document.querySelectorAll(".square").forEach(sq => {
          sq.classList.remove("highlight-move", "selected-square");
          sq.style.outline = "none";
        });
      },
      getPieceAt: pos => {
        const sq = document.querySelector(`.square[data-position="${pos}"]`);
        return sq ? sq.textContent : null;
      },
      
      isEnemy: (pos, piece) => {
        const target = utils.getPieceAt(pos);
        return target && utils.isPieceWhite(target) !== utils.isPieceWhite(piece);
      },
      isEmpty: pos => !utils.getPieceAt(pos),
      isOnBoard: (r, c) => r >= 1 && r <= 8 && c >= 97 && c <= 104
    };

    const logic = {
      isKingInCheck: (isWhite) => {
      const kingSymbol = isWhite ? "♔" : "♚";
      const kingSquare = [...document.querySelectorAll(".square")].find(
        sq => sq.textContent === kingSymbol
      );

      if (!kingSquare) return false; // Rey ya capturado

      const kingPos = kingSquare.dataset.position;

      // Buscar si alguna pieza enemiga puede capturarlo
      return [...document.querySelectorAll(".square")].some(sq => {
        const piece = sq.textContent;
        if (!piece || utils.isPieceWhite(piece) === isWhite) return false;

        const possibleMoves = logic.getMoves(sq);
        return possibleMoves.includes(kingPos);
      });
      },
      getMoves: (square) => {
        const pos = square.dataset.position;
        const col = pos.charCodeAt(0);
        const row = parseInt(pos[1]);
        const piece = square.textContent;
        const moves = [];

        const addIfValid = (r, c) => {
          if (!utils.isOnBoard(r, c)) return;
          const target = String.fromCharCode(c) + r;
          if (utils.isEmpty(target) || utils.isEnemy(target, piece)) {
            moves.push(target);
          }
        };

        if (piece === "♙") {
          const forward = row + 1;
          const fwdPos = String.fromCharCode(col) + forward;
          if (utils.isEmpty(fwdPos)) {
            moves.push(fwdPos);
            if (row === 2) {
              const dblFwd = String.fromCharCode(col) + (row + 2);
              if (utils.isEmpty(dblFwd)) moves.push(dblFwd);
            }
          }
          [[1, 1], [1, -1]].forEach(([dr, dc]) => {
            const capture = String.fromCharCode(col + dc) + (row + dr);
            if (utils.isEnemy(capture, piece)) moves.push(capture);
          });
        }

        else if (piece === "♟") {
          const forward = row - 1;
          const fwdPos = String.fromCharCode(col) + forward;
          if (utils.isEmpty(fwdPos)) {
            moves.push(fwdPos);
            if (row === 7) {
              const dblFwd = String.fromCharCode(col) + (row - 2);
              if (utils.isEmpty(dblFwd)) moves.push(dblFwd);
            }
          }
          [[-1, 1], [-1, -1]].forEach(([dr, dc]) => {
            const capture = String.fromCharCode(col + dc) + (row + dr);
            if (utils.isEnemy(capture, piece)) moves.push(capture);
          });
        }

        else if (["♖", "♜"].includes(piece)) {
          [[1, 0], [-1, 0], [0, 1], [0, -1]].forEach(([dr, dc]) => {
            let r = row + dr, c = col + dc;
            while (utils.isOnBoard(r, c)) {
              const p = String.fromCharCode(c) + r;
              if (utils.isEmpty(p)) moves.push(p);
              else {
                if (utils.isEnemy(p, piece)) moves.push(p);
                break;
              }
              r += dr; c += dc;
            }
          });
        }

        else if (["♘", "♞"].includes(piece)) {
          [[2, 1], [2, -1], [-2, 1], [-2, -1],
           [1, 2], [1, -2], [-1, 2], [-1, -2]].forEach(([dr, dc]) => {
            addIfValid(row + dr, col + dc);
          });
        }

        else if (["♗", "♝"].includes(piece)) {
          [[1, 1], [1, -1], [-1, 1], [-1, -1]].forEach(([dr, dc]) => {
            let r = row + dr, c = col + dc;
            while (utils.isOnBoard(r, c)) {
              const p = String.fromCharCode(c) + r;
              if (utils.isEmpty(p)) moves.push(p);
              else {
                if (utils.isEnemy(p, piece)) moves.push(p);
                break;
              }
              r += dr; c += dc;
            }
          });
        }

        else if (["♕", "♛"].includes(piece)) {
          [[1, 0], [-1, 0], [0, 1], [0, -1],
           [1, 1], [1, -1], [-1, 1], [-1, -1]].forEach(([dr, dc]) => {
            let r = row + dr, c = col + dc;
            while (utils.isOnBoard(r, c)) {
              const p = String.fromCharCode(c) + r;
              if (utils.isEmpty(p)) moves.push(p);
              else {
                if (utils.isEnemy(p, piece)) moves.push(p);
                break;
              }
              r += dr; c += dc;
            }
          });
        }

        else if (["♔", "♚"].includes(piece)) {
          [[1, 0], [-1, 0], [0, 1], [0, -1],
           [1, 1], [1, -1], [-1, 1], [-1, -1]].forEach(([dr, dc]) => {
            addIfValid(row + dr, col + dc);
          });
        }

        return moves;
      },

      capturePiece: (captured, byWhite) => {
        const span = document.createElement("span");
        span.textContent = captured;
        span.classList.add("captured-icon");
        span.classList.add(utils.isPieceWhite(captured) ? "white-piece" : "black-piece");
        (byWhite ? htmlElements.capturedWhite : htmlElements.capturedBlack).appendChild(span);
      },

      handleClick: (square) => {
        if (!sessionStorage.getItem("username2")) {
          htmlElements.gameStatus.textContent = "Esperando jugador rival";
          return;
        }

        if (gameOver) return;

        const piece = square.textContent;

        if (!selectedSquare) {
          const kingInCheck = logic.isKingInCheck(isWhiteTurn);
          const isKing = piece === (isWhiteTurn ? "♔" : "♚");

          if (piece && isWhiteTurn === utils.isPieceWhite(piece)) {
            if (kingInCheck && !isKing) {
              htmlElements.gameStatus.textContent = "¡Tu rey está en jaque! Solo puedes moverlo.";
              setTimeout(() => {
                htmlElements.gameStatus.textContent = isWhiteTurn ? "Turno de Blancas" : "Turno de Negras";
              }, 1500);
              return;
            }

            utils.clearHighlights();   
            selectedSquare = square;
            square.classList.add("selected-square");

            const moves = logic.getMoves(square);
            moves.forEach(pos => {
              const sq = document.querySelector(`.square[data-position="${pos}"]`);
              if (sq) sq.classList.add("highlight-move");
            });
          } else {
            htmlElements.gameStatus.textContent = "No puedes mover esa pieza.";
            setTimeout(() => {
              htmlElements.gameStatus.textContent = isWhiteTurn ? "Turno de Blancas" : "Turno de Negras";
            }, 1500);
          }
        } else {
          if (square === selectedSquare) {
            utils.clearHighlights();
            selectedSquare = null;
          } else if (square.classList.contains("highlight-move")) {
            const captured = square.textContent;
            if (captured) logic.capturePiece(captured, isWhiteTurn);

            square.textContent = selectedSquare.textContent;
            selectedSquare.textContent = "";

            square.classList.remove("white-piece", "black-piece");
            square.classList.add(...selectedSquare.classList.contains("white-piece") ? ["white-piece"] : ["black-piece"]);
            selectedSquare.classList.remove("white-piece", "black-piece");

            if (captured === "♔" || captured === "♚") {
              gameOver = true;
              htmlElements.gameStatus.innerHTML = `<strong style="color: green;">${captured === "♚" ? "¡Victoria de Blancas!" : "¡Victoria de Negras!"}</strong>`;
              htmlElements.passBtn.style.display = "none";
              htmlElements.restartBtn.style.display = "inline-block";
              return;
            }

            utils.clearHighlights();
            selectedSquare = null;
            isWhiteTurn = !isWhiteTurn;
            htmlElements.gameStatus.innerHTML = isWhiteTurn
              ? '⚪ Turno de <span style="color: #f0f0f0;">Blancas ♙</span>'
              : '⚫ Turno de <span style="color: #f0f0f0;">Negras ♟</span>';
          }
        }
      }

    };

    const handlers = {
      buildBoard: () => {
        htmlElements.board.innerHTML = "";
        for (let row = 8; row >= 1; row--) {
          for (let col = 0; col < 8; col++) {
            const pos = letters[col] + row;
            const sq = document.createElement("div");
            sq.className = `square ${(row + col) % 2 === 0 ? "white" : "black"}`;
            sq.dataset.position = pos;

            const piece = initialPositions[pos];
            if (piece) {
              sq.textContent = piece;
              sq.classList.add(utils.isPieceWhite(piece) ? "white-piece" : "black-piece");
            }

            sq.addEventListener("click", () => logic.handleClick(sq));
            htmlElements.board.appendChild(sq);
          }
        }
        htmlElements.gameStatus.textContent = sessionStorage.getItem("username2")
          ? "Turno de Blancas"
          : "Esperando jugador rival";
      },

      bindButtons: () => {
        htmlElements.passBtn.addEventListener("click", () => {
          if (gameOver) return;
          gameOver = true;
          htmlElements.gameStatus.innerHTML = `<strong style="color: green;">${isWhiteTurn ? "¡Victoria de Negras por rendición!" : "¡Victoria de Blancas por rendición!"}</strong>`;
          htmlElements.passBtn.style.display = "none";
          htmlElements.restartBtn.style.display = "inline-block";
        });

        htmlElements.restartBtn.addEventListener("click", () => location.reload());
      }
    };

    return {
      init: () => {
        handlers.buildBoard();
        handlers.bindButtons();
      }
    };
  })();

  ChessGame.init();
})();
