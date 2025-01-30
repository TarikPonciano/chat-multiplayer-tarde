extends Control

const PORT = 3333
const ADDRESS = "127.0.0.1"
var participantes = []



func _on_botao_enviar_pressed() -> void:
	var mensagem = $CampoMensagem.text
	var nome = $CampoNome.text
	
	if nome == "":
		nome = "Anônimo"
	
	if mensagem != "":
		rpc("atualizar_chat",mensagem, nome)
		$CampoMensagem.text = ""
		$CampoMensagem.placeholder_text = "Digite uma nova mensagem..."
	else:
		$CampoMensagem.placeholder_text = "VOCÊ NÃO PODE ENVIAR TEXTO VAZIO! ESCREVA ALGO!" 


func _on_botao_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(cliente_conectado)
	print("Servidor criado na porta "+str(PORT))
	participantes.append($CampoNome.text)
	rpc("atualizar_participantes", participantes)

func cliente_conectado(id):
	print("Cliente conectado no servidor!" + str(id))
	

func _on_botao_join_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(enviar_informacoes)
	
func enviar_informacoes():
	var nome = $CampoNome.text
	rpc("atualizar_informacoes", nome)
#any_peer > Qualquer janela pode ativar essa função	
#authority > Algo que só vai ser feito pelo servidor

#call_local > Manda para todos e faz na própria máquina
#call_remote > Apenas manda a informação
@rpc("any_peer", "call_local", "reliable")
func atualizar_chat(mensagem, nome):
	$CaixaMensagens.text += nome + ": " + mensagem + "\n"
	

@rpc("any_peer", "call_local", "reliable")
func atualizar_participantes(participantes_servidor):
	participantes = participantes_servidor
	$ListaParticipantes.text = ""
	for participante in participantes:
		$ListaParticipantes.text += participante + "\n"
	
@rpc("any_peer", "call_local", "reliable")
func atualizar_informacoes(nome):
	if multiplayer.is_server():
		participantes.append(nome)
		rpc("atualizar_participantes", participantes)
