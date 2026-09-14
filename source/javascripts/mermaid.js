function renderMermaidDiagrams () {
    var mermaidContainers = document.querySelectorAll('.mermaid');

    if (mermaidContainers.length === 0) {
        return;
    }

    var mermaidScript = document.createElement('script');
    mermaidScript.src = 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js';
    mermaidScript.onload = function () {
        mermaid.initialize({
            startOnLoad: false,
            securityLevel: 'strict'
        });
        mermaid.run({ nodes: mermaidContainers })
            .then(function () {
                enableMermaidFullscreen(mermaidContainers);
            })
            .catch(function (error) {
                console.error('Mermaid diagram rendering failed. Check the diagram syntax:', error);
            });
    };
    mermaidScript.onerror = function (error) {
        console.error('Mermaid library failed to load:', error);
    };
    document.head.appendChild(mermaidScript);
}

var panzoomScriptPromise;

function loadPanzoom () {
    if (!panzoomScriptPromise) {
        panzoomScriptPromise = new Promise(function (resolve, reject) {
            var panzoomScript = document.createElement('script');
            panzoomScript.src = 'https://cdn.jsdelivr.net/npm/@panzoom/panzoom@4.6.0/dist/panzoom.min.js';
            panzoomScript.onload = resolve;
            panzoomScript.onerror = reject;
            document.head.appendChild(panzoomScript);
        });
    }

    return panzoomScriptPromise;
}

function resetPanzoom (mermaidContainer, panzoom, wheelHandler) {
    if (panzoom) {
        mermaidContainer.removeEventListener('wheel', wheelHandler);
        panzoom.reset();
        panzoom.destroy();
    }
    mermaidContainer.style.removeProperty('overflow');
    mermaidContainer.style.removeProperty('touch-action');
    mermaidContainer.scrollTo(0, 0);
}

function enableMermaidFullscreen (mermaidContainers) {
    if (!document.fullscreenEnabled) {
        return;
    }

    // Loop through all mermaid containers and append full screen click listener to each
    mermaidContainers.forEach(function (mermaidContainer) {
        mermaidContainer.style.cursor = 'pointer';
        mermaidContainer.title = 'Click to view diagram full screen, drag and zoom';

        var panzoom;
        var wheelHandler;
        var exitFullscreenButton;

        mermaidContainer.addEventListener('click', () => {
            if (!document.fullscreenElement) {
                mermaidContainer.requestFullscreen().catch(function (error) {
                    console.error('Unable to open Mermaid diagram in full screen:', error);
                });
            }
        });

        document.addEventListener('fullscreenchange', () => {
            var isFullscreen = document.fullscreenElement === mermaidContainer;
            if (isFullscreen) {
                exitFullscreenButton = document.createElement('button');
                exitFullscreenButton.className = 'mermaid__fullscreen-exit';
                exitFullscreenButton.type = 'button';
                exitFullscreenButton.textContent = 'Exit full screen';

                exitFullscreenButton.addEventListener('click', function (event) {
                    event.stopPropagation();
                    resetPanzoom(mermaidContainer, panzoom, wheelHandler);
                    panzoom = null;
                    wheelHandler = null;
                    document.exitFullscreen();
                });

                mermaidContainer.appendChild(exitFullscreenButton);
                loadPanzoom().then(() => {
                    if (document.fullscreenElement !== mermaidContainer) {
                        return;
                    }
                    var svg = mermaidContainer.querySelector('svg');
                    if (svg) {
                        panzoom = Panzoom(svg, {
                            maxScale: 8,
                            minScale: 0.5
                        });
                        wheelHandler = panzoom.zoomWithWheel;
                        mermaidContainer.style.overflow = 'hidden';
                        mermaidContainer.style.touchAction = 'none';
                        mermaidContainer.addEventListener('wheel', wheelHandler);
                    }
                }).catch((error) => {
                    console.error('Panzoom library failed to load:', error);
                });
            } else if (exitFullscreenButton) {
                resetPanzoom(mermaidContainer, panzoom, wheelHandler);
                exitFullscreenButton.remove();
                exitFullscreenButton = null;
                panzoom = null;
                wheelHandler = null;
            }
        });
    });
}

document.addEventListener('DOMContentLoaded', renderMermaidDiagrams);
