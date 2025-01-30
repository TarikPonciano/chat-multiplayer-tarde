extends Control


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
