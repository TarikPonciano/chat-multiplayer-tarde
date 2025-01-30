extends Control

const PORT = 3333

func _on_botao_enviar_pressed() -> void:
	var mensagem = $CampoMensagem.text
	var nome = $CampoNome.text
	
	if nome == "":
		nome = "Anônimo"
	
	if mensagem != "":
		$CaixaMensagens.text += nome + ": " + mensagem + "\n"
		$CampoMensagem.text = ""
		$CampoMensagem.placeholder_text = "Digite sua mensagem..." 
	else:
		$CampoMensagem.placeholder_text = "VOCÊ NÃO PODE ENVIAR TEXTO VAZIO! ESCREVA ALGO!" 


func _on_botao_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	$CaixaMensagens.text += "Servidor criado na porta "+str(PORT)
