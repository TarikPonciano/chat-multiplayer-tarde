extends Control

@onready var chat = $CaixaChat
@onready var mensagem = $CampoMensagem
@onready var botaoEnviar = $BotaoEnviar
@onready var nomeUsuario = $CampoNomeUsuario


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enviar_mensagem() -> void:
	if (mensagem.text == ""):
		print("Texto vazio!")
	else:
		chat.text += nomeUsuario.text + ": " + mensagem.text + "\n" 
		
		mensagem.text = ""

func _on_botao_join_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 3333)
	multiplayer.multiplayer_peer = peer
	
func _on_botao_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(3333)
	multiplayer.multiplayer_peer = peer
	multiplayer.multiplayer_peer.peer_connected.connect(entrou)

func entrou(id):
	print("O usuário ",id," entrou!")
