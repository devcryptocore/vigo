function tieneSoporteUserMedia() {
    return !!(navigator.getUserMedia || (navigator.mozGetUserMedia || navigator.mediaDevices.getUserMedia) || navigator.webkitGetUserMedia || navigator.msGetUserMedia)
}
function _getUserMedia() {
    return (navigator.getUserMedia || (navigator.mozGetUserMedia || navigator.mediaDevices.getUserMedia) || navigator.webkitGetUserMedia || navigator.msGetUserMedia).apply(navigator, arguments);
}
 
const $video = document.querySelector("#video"),
    $canvas = document.querySelector("#canvas"),
    $boton = document.querySelector("#boton"),
    $estado = document.querySelector("#estado"),
    $listaDeDispositivos = document.querySelector("#listaDeDispositivos");
 
const llenarSelectConDispositivosDisponibles = () => {
 
    navigator
        .mediaDevices
        .enumerateDevices()
        .then(function (dispositivos) {
            const dispositivosDeVideo = [];
            dispositivos.forEach(function (dispositivo) {
                const tipo = dispositivo.kind;
                if (tipo === "videoinput") {
                    dispositivosDeVideo.push(dispositivo);
                }
            });
 
            if (dispositivosDeVideo.length > 0) {
                dispositivosDeVideo.forEach(dispositivo => {
                    const option = document.createElement('option');
                    option.value = dispositivo.deviceId;
                    option.text = dispositivo.label;
                    $listaDeDispositivos.appendChild(option);
                    console.log("$listaDeDispositivos => ", $listaDeDispositivos)
                });
            }
        });
}
 
(function () {
    if (!tieneSoporteUserMedia()) {
        alert("Tu navegador no es soportado.");
        $estado.innerHTML = "Se debe usar un navegador Chrome o Mozilla para usar esta aplicación";
        return;
    }
    let stream;
 
    navigator
        .mediaDevices
        .enumerateDevices()
        .then(function (dispositivos) {
            const dispositivosDeVideo = [];
 
            dispositivos.forEach(function (dispositivo) {
                const tipo = dispositivo.kind;
                if (tipo === "videoinput") {
                    dispositivosDeVideo.push(dispositivo);
                }
            });

            if (dispositivosDeVideo.length > 0) {
                mostrarStream(dispositivosDeVideo[0].deviceId);
            }
        });
 
 
 
    const mostrarStream = idDeDispositivo => {
        _getUserMedia(
            {
                video: {

                    deviceId: idDeDispositivo,
                }
            },
            function (streamObtenido) {
               
                llenarSelectConDispositivosDisponibles();
 
                $listaDeDispositivos.onchange = () => {
                    if (stream) {
                        stream.getTracks().forEach(function (track) {
                            track.stop();
                        });
                    }
        
                    mostrarStream($listaDeDispositivos.value);
                }
 
              
                stream = streamObtenido;
 
                
                $video.srcObject = stream;
                $video.play();
 
              
                $boton.addEventListener("click", function () {
 
                   
                    $video.pause();
 
                    
                    let contexto = $canvas.getContext("2d");
                    $canvas.width = $video.videoWidth;
                    $canvas.height = $video.videoHeight;
                    contexto.drawImage($video, 0, 0, $canvas.width, $canvas.height);
 
                    let foto = $canvas.toDataURL();
                    $estado.innerHTML = `<p style="color: #dbea41">Procesando, espere...</p>`;
                    fetch("./script.php", {
                        method: "POST",
                        body: encodeURIComponent(foto),
                        headers: {
                            "Content-type": "application/x-www-form-urlencoded",
                        }
                    })
                        .then(resultado => {

                            return resultado.text()
                        })
                        .then(nombreDeLaFoto => {

                            console.log("Imagen adquirida con éxito!");
                            $estado.innerHTML = ` <a target='_blank' href='./images/capture_345565.png'><button type="button" style="color: #504e4e;margin-top: 20px;font-size: 18px;font-family: "Roboto", sans-serif;background-color: #8bc34a;width: 250px;height: 50px;border-radius: 10px;text-align: center;border-bottom-width: 0px;border-top-width: 0px;border-left-width: 0px;border-right-width: 0px;">Ver Imagen</button></a>`;
                        })
 
                    $video.play();
                });
            }, function (error) {
                console.log("Error: ", error);
                $estado.innerHTML = "Debes otorgar permiso para que esta aplicación funcione!.<br>Recarga la página y presiona en 'Permitir'";
            });
    }
})();