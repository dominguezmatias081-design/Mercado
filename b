<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Mercado Negro VIP</title>
    <style>
        :root {
            --bg-color: #111;
            --text-color: #fff;
            --button-bg: #ff0000;
            --button-active: #cc0000;
            --card-bg: #222;
            --border-color: #444;
            --success-color: #4CAF50;
            --error-color: #f44336;
        }

        .light-mode {
            --bg-color: #f5f5f5;
            --text-color: #333;
            --button-bg: #007BFF;
            --button-active: #0056b3;
            --card-bg: #fff;
            --border-color: #ddd;
            --success-color: #2E7D32;
            --error-color: #C62828;
        }

        * {
            box-sizing: border-box;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            text-align: center;
            touch-action: manipulation;
            transition: background-color 0.3s, color 0.3s;
        }

        /* Pantallas de carga */
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: var(--bg-color);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-spinner {
            border: 5px solid var(--border-color);
            border-top: 5px solid var(--button-bg);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .loading-text {
            color: var(--text-color);
            margin: 20px;
            font-size: 1.2rem;
            height: 60px;
            max-width: 80%;
        }

        /* Botones */
        button {
            background-color: var(--button-bg);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 1.1rem;
            margin: 10px auto;
            width: 90%;
            max-width: 300px;
            transition: transform 0.1s;
            cursor: pointer;
            user-select: none;
        }

        button:active {
            transform: scale(0.95);
            background-color: var(--button-active);
        }

        /* Inputs */
        input {
            padding: 15px;
            margin: 15px auto;
            width: 90%;
            max-width: 300px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            font-size: 1rem;
            background-color: var(--card-bg);
            color: var(--text-color);
        }

        /* Pantallas */
        .screen {
            display: none;
            padding: 20px 10px;
            min-height: 100vh;
        }

        /* Items */
        .item {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 15px;
            margin: 15px auto;
            max-width: 500px;
            text-align: left;
        }

        /* Tabs */
        .tab-container {
            display: flex;
            margin-bottom: 15px;
            overflow-x: auto;
            white-space: nowrap;
            padding: 5px 0;
        }

        .tab {
            padding: 10px 20px;
            background-color: var(--card-bg);
            cursor: pointer;
            border: 1px solid var(--border-color);
            margin: 0 5px;
            border-radius: 5px;
            display: inline-block;
        }

        .tab.active {
            background-color: var(--button-bg);
            color: white;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Chat */
        .chat-container {
            height: 300px;
            border: 1px solid var(--border-color);
            overflow-y: scroll;
            margin-bottom: 10px;
            padding: 10px;
            background-color: var(--card-bg);
            border-radius: 10px;
        }

        .message {
            margin-bottom: 10px;
            padding: 8px 12px;
            border-radius: 15px;
            max-width: 80%;
            word-wrap: break-word;
        }

        .message.sent {
            background-color: var(--button-bg);
            color: white;
            margin-left: auto;
            border-bottom-right-radius: 0;
        }

        .message.received {
            background-color: var(--border-color);
            margin-right: auto;
            border-bottom-left-radius: 0;
        }

        /* Minijuegos */
        .mini-game {
            background-color: var(--card-bg);
            padding: 15px;
            margin: 15px auto;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            max-width: 500px;
        }

        .game-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 5px;
            margin: 10px 0;
        }

        .game-cell {
            background-color: var(--border-color);
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            border-radius: 5px;
        }

        .game-cell:active {
            transform: scale(0.9);
        }

        /* Reputación */
        .player-reputation {
            position: fixed;
            top: 10px;
            right: 10px;
            background-color: var(--card-bg);
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid var(--button-bg);
            z-index: 1000;
            font-size: 0.9rem;
        }

        /* Modo claro/oscuro */
        .theme-switcher {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: var(--button-bg);
            color: white;
            border: none;
            font-size: 1.5rem;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }

        /* Eventos aleatorios */
        .random-event {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: var(--card-bg);
            border: 3px solid var(--button-bg);
            padding: 20px;
            z-index: 2000;
            width: 90%;
            max-width: 400px;
            text-align: center;
            border-radius: 10px;
        }

        /* Adaptación móvil */
        @media (max-width: 480px) {
            .tab {
                padding: 8px 12px;
                font-size: 0.9rem;
            }
            
            .message {
                max-width: 90%;
            }
        }
    </style>
</head>
<body>
    <!-- Pantallas de carga -->
    <div class="loading-screen" id="initialLoading">
        <div class="loading-spinner"></div>
        <div class="loading-text" id="initialText">Conectando a servidores seguros...</div>
    </div>

    <div class="loading-screen" id="marketLoading" style="display: none;">
        <div class="loading-spinner"></div>
        <div class="loading-text">Accediendo a la red oscura...</div>
    </div>

    <div class="loading-screen" id="gamesLoading" style="display: none;">
        <div class="loading-spinner"></div>
        <div class="loading-text">Iniciando módulos de entrenamiento...</div>
    </div>

    <!-- Barra de reputación -->
    <div class="player-reputation">
        🔥 Rep: <span id="reputationValue">50%</span> | ⭐ <span id="repStars">★★★☆☆</span>
    </div>

    <!-- Botón de cambio de tema -->
    <button class="theme-switcher" onclick="toggleTheme()">🌓</button>

    <!-- Tienda normal -->
    <div class="screen" id="normalShop">
        <h1>🛒 Tienda Legal</h1>
        <p>Productos 100% legales... en apariencia</p>
        
        <div class="item">
            <h3>📱 Teléfono Reacondicionado</h3>
            <p>💰 Precio: $200 USD</p>
            <button>Comprar</button>
        </div>
        
        <div class="item">
            <h3>🔦 Linterna Táctica</h3>
            <p>💰 Precio: $45 USD</p>
            <button>Comprar</button>
        </div>
        
        <div class="item">
            <h3>📚 Libro "Historia Prohibida"</h3>
            <p>💰 Precio: $120 USD</p>
            <button>Comprar</button>
        </div>
        
        <button class="secret-button" onclick="showSecretAccess()">🚪 Acceso Secreto (Código: 111111)</button>
    </div>

    <!-- Acceso secreto -->
    <div class="screen" id="secretAccess" style="display: none;">
        <h1>🔒 Acceso Restringido</h1>
        <input type="password" id="accessCode" placeholder="Ingresa el código">
        <button onclick="checkAccessCode()">Entrar</button>
        <p id="errorMsg" style="color: var(--error-color);"></p>
        <button onclick="backToNormalShop()">⬅️ Volver a la tienda</button>
    </div>

    <!-- Mercado Negro -->
    <div class="screen" id="marketScreen" style="display: none;">
        <div class="tab-container">
            <div class="tab active" onclick="switchTab('products')">Productos</div>
            <div class="tab" onclick="switchTab('auctions')">Subastas</div>
            <div class="tab" onclick="switchTab('contracts')">Contratos</div>
            <div class="tab" onclick="switchTab('chat')">Chat IA</div>
            <div class="tab" onclick="switchTab('games')">Minijuegos</div>
        </div>
        
        <!-- Productos -->
        <div id="products-tab" class="tab-content active">
            <h2>🕵️‍♂️ Mercado Negro</h2>
            
            <div class="item">
                <h3>🐍 Pitón Albina (Viva)</h3>
                <p>💰 Precio: $5,000 USD</p>
                <p>👤 Vendedor: <strong>El Coyote</strong> (⭐⭐⭐⭐☆)</p>
                <button>🖤 Comprar</button>
            </div>
            
            <div class="item">
                <h3>🔫 Glock 18 (Sin serial)</h3>
                <p>💰 Precio: $3,200 USD</p>
                <p>👤 Vendedor: <strong>El Armero</strong> (⭐⭐⭐☆☆)</p>
                <button>🖤 Comprar</button>
            </div>
            
            <div class="item">
                <h3>💎 Diamante Sangriento</h3>
                <p>💰 Precio: $25,000 USD</p>
                <p>👤 Vendedor: <strong>La Sombra</strong> (⭐⭐☆☆☆)</p>
                <button>🖤 Comprar</button>
            </div>
        </div>
        
        <!-- Chat IA -->
        <div id="chat-tab" class="tab-content">
            <h2>🤖 Chat con Vendedores</h2>
            
            <select id="sellerSelect" onchange="changeSeller()" style="width: 90%; padding: 10px; margin: 10px auto;">
                <option value="coyote">El Coyote (Animales)</option>
                <option value="doctor">El Doctor (Químicos)</option>
                <option value="tecnico">El Técnico (Electrónica)</option>
            </select>
            
            <div class="chat-container" id="iaChatBox">
                <div class="message received">
                    <strong>El Coyote:</strong> Hola. ¿Buscas algo especial hoy?
                </div>
            </div>
            
            <input type="text" id="iaMessage" placeholder="Escribe tu mensaje...">
            <button onclick="sendIAMessage()">📤 Enviar</button>
        </div>
        
        <!-- Minijuegos -->
        <div id="games-tab" class="tab-content">
            <h2>🎮 Minijuegos</h2>
            
            <div class="mini-game">
                <h3>💻 Hackeo de Seguridad</h3>
                <p>Encuentra el código correcto para acceder al sistema</p>
                <div class="game-grid" id="hackingGame"></div>
                <p>🔓 Progreso: <span id="hackProgress">0%</span></p>
                <div style="width: 100%; height: 10px; background-color: var(--border-color); border-radius: 5px;">
                    <div id="hackBar" style="height: 100%; width: 0%; background-color: var(--success-color); border-radius: 5px;"></div>
                </div>
            </div>
            
            <div class="mini-game">
                <h3>👤 Modo Sigilo</h3>
                <p>Evita las cámaras de seguridad</p>
                <div class="game-grid" id="stealthGame"></div>
                <p>🎯 Puntos: <span id="stealthPoints">0</span>/10</p>
            </div>
        </div>
        
        <button onclick="backToNormalShop()" style="margin-top: 20px;">⬅️ Volver a la tienda</button>
    </div>

    <!-- Evento aleatorio: Redada -->
    <div class="random-event" id="policeRaid" style="display: none;">
        <h2>🚨 ¡REDADA POLICIAL! 🚔</h2>
        <p>La policía está registrando la zona. ¿Qué haces?</p>
        <button onclick="escapeRaid()">🏃‍♂️ Huir (-20% reputación)</button>
        <button onclick="fightRaid()">🔫 Resistir (+5% reputación)</button>
        <button onclick="bribeRaid()">💰 Sobornar ($5,000 USD)</button>
    </div>

    <script>
        // Variables globales
        let playerReputation = 50;
        let currentSeller = null;
        let sellerMemory = {};
        let loadingStories = [
            "Estableciendo conexión encriptada...",
            "Bypasseando firewalls...",
            "Verificando credenciales...",
            "Accediendo a la red oscura...",
            "¡Conexión exitosa!"
        ];

        // Base de datos de vendedores IA
        const sellers = {
            "coyote": {
                name: "El Coyote",
                desc: "Especialista en fauna prohibida. Contacto seguro.",
                skills: ["Animales", "Falsificación"],
                responses: [
                    "Tengo un lote de pitones albinas listo para viajar.",
                    "¿Necesitas papeles falsos para el animal? +$2,000 USD.",
                    "Solo acepto Monero (XMR). ¿De acuerdo?",
                    "El envío tarda 48h. ¿Dirección de entrega?",
                    "No hago preguntas, tú no las hagas."
                ]
            },
            "doctor": {
                name: "El Doctor",
                desc: "Cirujano clandestino. Productos 'médicos' de alto riesgo.",
                skills: ["Química", "Biohacking"],
                responses: [
                    "La adrenalina pura está en stock. ¿Cuántas ampolletas?",
                    "⚠️ Este producto requiere manejo especial.",
                    "Pago por adelantado. No hay reembolsos.",
                    "Puedo conseguir órganos... si el precio es correcto.",
                    "¿Eres policía? Porque suenas a policía."
                ]
            },
            "tecnico": {
                name: "El Técnico",
                desc: "Hardware robado y modificado. Sin preguntas.",
                skills: ["Electrónica", "Hacking"],
                responses: [
                    "Tengo laptops sin serial. ¿Interesado?",
                    "Puedo desbloquear cualquier dispositivo. $500 USD c/u.",
                    "Solo entrego en puntos ciegos de la ciudad.",
                    "¿Necesitas interceptar llamadas? Tengo el equipo.",
                    "No trabajo con amateurs. ¿Cuál es tu experiencia?"
                ]
            }
        };

        // Sonidos
        const sounds = {
            click: new Audio('https://assets.mixkit.co/sfx/preview/mixkit-select-click-1109.mp3'),
            success: new Audio('https://assets.mixkit.co/sfx/preview/mixkit-achievement-bell-600.mp3'),
            error: new Audio('https://assets.mixkit.co/sfx/preview/mixkit-warning-alarm-688.mp3'),
            loading: new Audio('https://assets.mixkit.co/sfx/preview/mixkit-sci-fi-positron-beep-908.mp3')
        };

        // Inicialización
        window.onload = function() {
            // Cargar tema guardado
            if (localStorage.getItem('theme') === 'light') {
                document.body.classList.add('light-mode');
            }

            // Simular carga inicial
            simulateLoadingWithStory(
                document.getElementById("initialLoading"),
                document.getElementById("initialText"),
                function() {
                    document.getElementById("normalShop").style.display = "block";
                    initHackingGame();
                    initStealthGame();
                    updateReputation(0);
                    
                    // Vibrar al cargar completo
                    vibrate(200);
                }
            );

            // Configurar Service Worker para offline
            if ('serviceWorker' in navigator) {
                navigator.serviceWorker.register('sw.js')
                    .then(() => console.log('Service Worker registrado'))
                    .catch(err => console.log('Error en SW:', err));
            }
        };

        // Funciones de carga
        function simulateLoadingWithStory(loadingElement, textElement, callback) {
            let progress = 0;
            const totalSteps = loadingStories.length;
            
            sounds.loading.play().catch(e => console.log("Sonido bloqueado"));
            
            const interval = setInterval(() => {
                if (progress < totalSteps) {
                    textElement.textContent = loadingStories[progress];
                    progress++;
                    
                    // Reproducir sonido cada 2 pasos
                    if (progress % 2 === 0) {
                        playSound('click');
                    }
                } else {
                    clearInterval(interval);
                    loadingElement.style.display = "none";
                    callback();
                    playSound('success');
                }
            }, 1000);
        }

        // Funciones de sonido y vibración
        function playSound(type) {
            sounds[type].play().catch(e => console.log("Sonido bloqueado"));
        }

        function vibrate(duration) {
            if (navigator.vibrate) navigator.vibrate(duration);
        }

        // Funciones de la tienda
        function showSecretAccess() {
            document.getElementById("normalShop").style.display = "none";
            document.getElementById("secretAccess").style.display = "block";
            playSound('click');
            vibrate(50);
        }

        function backToNormalShop() {
            document.getElementById("marketScreen").style.display = "none";
            document.getElementById("secretAccess").style.display = "none";
            document.getElementById("normalShop").style.display = "block";
            playSound('click');
            vibrate(50);
        }

        function checkAccessCode() {
            const code = document.getElementById("accessCode").value;
            if (code === "111111") {
                playSound('success');
                document.getElementById("secretAccess").style.display = "none";
                document.getElementById("marketLoading").style.display = "flex";
                
                simulateLoadingWithStory(
                    document.getElementById("marketLoading"),
                    document.querySelector("#marketLoading .loading-text"),
                    function() {
                        document.getElementById("marketScreen").style.displ