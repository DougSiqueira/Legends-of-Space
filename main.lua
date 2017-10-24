require "controle"
require "mecanica"
require "camera" 
require "inimigos"
require "ranking"

success = love.window.setMode(400, 700, {resizable=true})  --diminuindo tamanho da tela
larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()
time = 0
time2 = 0
ast=0
levandoDano = false
tempoDano = 0

--rank
score = {}
nomes = {}
k = 0
aux = -1
auxName = " "
play = ""
nome = false



--mouse pisição
mx = 0
my = 0

function love.load()
  love.window.setTitle("Legends of Space") --Nome do jogo

  -- mouse
  imgMouse = love.graphics.newImage("imagens/Nave1.png")
  love.mouse.setVisible(false)

-- apresentaçao
  imgApresentacao = love.graphics.newImage("imagens/Story.png")
  apresentando = true
  apresentacao = {
    x=0,
    y=alturaTela,
    velocidade = 17
  }



--Menu do jogo
  imgMenuJogo = love.graphics.newImage("imagens/menu.png")
  menu = false
  

-- Apresentar ranking
  imgRanking = love.graphics.newImage("imagens/Rankingback1.png")
  ranking = false


--Tela de novo jogo
  novoJogo = false
  telaTitulo = love.graphics.newImage("imagens/LOS.png")
  dX = 0
  dY = 0

  -- segundos fundos
  imgFundo = love.graphics.newImage("imagens/universo/imagem_01.png") --imagem de fundo
  imgFundo2 = love.graphics.newImage("imagens/universo/imagem_02.png")


  planoDeFundo = {
    x=0,
    y=0,
    y2= 0 - imgFundo:getHeight(),
    velocidade = 30
  }

  -- Inimigos
  delayInimigo = 2--0.5
  tempoCriarInimigo = delayInimigo
  velocidadeInimigo = 150--200

  imgInimigo1 = love.graphics.newImage("imagens/inimigo1.png")
  imgInimigo2 = love.graphics.newImage("imagens/inimigo2.png")
  imgInimigo = imgInimigo1
  inimigos = {}

--Explosão
  expInimigo = {}
  imgExplosao = {}
  for i=1,25,1 do
    if i < 10 then
      imgExplosao[i] = love.graphics.newImage("imagens/explosao/EXPLODINDO_0"..i..".png")
    else
      imgExplosao[i] = love.graphics.newImage("imagens/explosao/EXPLODINDO_"..i..".png")
    end

  end

--Fonte nova
  fonte = "fontes/funnypagesital.ttf"
  fonte1 = "fontes/SF Collegiate Solid.ttf"

  --Asteroide
  delayAsteroide = 4
  tempoAteCair = delayAsteroide
  velocidadeAsteroide = 300
  imgAsteroide = {}
  for i=0,15,1 do
    if i < 10 then
      imgAsteroide[i] = love.graphics.newImage("imagens/asteroides/a3000"..i.." (2).png")
    else
      imgAsteroide[i] = love.graphics.newImage("imagens/asteroides/a300"..i.." (2).png")
    end
  end
  asteroides = {}


  --Nave player  
  imgNave = love.graphics.newImage("imagens/Nave3.png") --imagem da nave
  imgNaveDano = love.graphics.newImage("imagens/Nave31.png")

  nave = {
    posX = larguraTela/2,
    posY = alturaTela/2,
    velocidade = 200
  }

  -- Tiros
  atira = true
  delayTiro = 0.5
  tempoAteAtirar = delayTiro
  velocidadeTiro = 500
  tiros = {}
  imgTiro = love.graphics.newImage("imagens/Projetil2.png")
  imgTiro2 = love.graphics.newImage("imagens/Projetil.png")
  imgTiro3 = love.graphics.newImage("imagens/Projetil4.png")
  tiroLvl=0


  --Itens, update tiro
  delayUpTiro = 20
  tempoCairUp = delayUpTiro
  velocidadeUpTiro = 400
  upTiros = {}
  imgUpTiro = love.graphics.newImage("imagens/Up.png")
  imgUpTiro1 = love.graphics.newImage("imagens/Up2.png")


-- Vidas
  estaVivo = flase
  vidas = 3
  
  --Game Over
  gameOver = false
  transparencia = 0
  imgGameOver = love.graphics.newImage("imagens/Game Over.png")

--Pontos
  pontos = 0

  --Carregar Rank
  LoadScore("score.txt", "nomes.txt" ,3)

  --Sons do jogo
  somApresentacao = love.audio.newSource("sons/StarFox.mp3")
  somMenu = love.audio.newSource("sons/menuStar.mp3")
  somDoTiro = love.audio.newSource("sons/Tiro.wav", "static")
  explodeNave = love.audio.newSource("sons/ExplodeNave.wav", "static")
  explodeNaveInimigo = love.audio.newSource("sons/ExplodeInimigo.wav", "static")
  musicaFase = love.audio.newSource("sons/14. John Wick Chapter 2 - John Wick Mode.mp3")


-- Tela de jogo
  abreTela = false


-- Pausar
  pausado = false

  --Lvl dos inimigos
  nivelInimigos = 0

end

function love.update(dt)
  mx = love.mouse.getX()  
  my = love.mouse.getY()

  if apresentando then
    somApresentacao:play()
    Apresentando(dt)
    cortaApresnetacao ()

  else 
    if menu then
      somMenu:play()
      menuOpcao()

    else
      if ranking then
        fecharRanking()
      else
        if novoJogo then
          IniciarJogo()

        else
          if not pausado then 
            checaDano(dt)
            camera(dt)
            anintime(15, dt)
            aninExplosao(25, dt)
            movimentos(dt)
            resetar()
            atirar(dt)
            inimigo(dt)
            asteroide(dt)
            colisao()
            iniciarJogo(dt)
            levelJogo()
            upTiro(dt)
            colisaoUp()
          end
        
          if gameOver then
            inserirNoRank()
            pausado = true
            GameOver(dt)
          end
        end
      end
    end
  end  
end



function love.draw()

  if apresentando then  -- Apresentação
    love.graphics.draw(imgApresentacao, apresentacao.x, apresentacao.y)


  else

    if menu then -- Menu de opções
      love.graphics.draw(imgMenuJogo, dX, dY)

      love.graphics.draw(imgMouse, mx, my)


    else
      if ranking then -- Ranking atual do jogo
        love.graphics.draw(imgRanking, 0, 0)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(fonte, 30))
        love.graphics.print("\n"..nomes[0]..":  "..score[0], larguraTela/3, alturaTela/3, 0, 1, 1)
        love.graphics.print("\n\n"..nomes[1]..":  "..score[1], larguraTela/3, alturaTela/3 + 30, 0, 1, 1)
        love.graphics.print("\n\n\n"..nomes[2]..":  ".. score[2], larguraTela/3, alturaTela/3 + 60, 0, 1, 1)
        love.graphics.print("\n\n\n\n"..nomes[3]..":  ".. score[3], larguraTela/3, alturaTela/3 + 90, 0, 1, 1)
        love.graphics.setColor(255, 255, 255)

      else

        if novoJogo then -- Iniciando um novo Jogo

          love.graphics.draw(telaTitulo, dX, dY )
          --love.graphics.print(play.." ", 100, 500)
          love.graphics.setColor(0, 0, 0, 255)
          love.graphics.setFont(love.graphics.newFont(fonte1, 30))
          love.graphics.print("Nickname: "..play.." ", 100, 500)
          love.graphics.setColor(255, 255, 255)
        else

          if not gameOver then

            -- Desenha background
            love.graphics.draw(imgFundo, planoDeFundo.x, planoDeFundo.y)
            love.graphics.draw (imgFundo2, planoDeFundo.x, planoDeFundo.y2)

            -- Desenhar os Tiros
            for i, tiro in ipairs(tiros) do
              love.graphics.draw(tiro.img, tiro.x, tiro.y, 0, 1, 1, imgTiro:getWidth()/2, imgTiro:getHeight())
            end

            -- Desenhar inimigos
            for i, inimigo in ipairs(inimigos) do 
              love.graphics.draw(imgInimigo, inimigo.x, inimigo.y, 0, 1, 1, imgInimigo:getWidth()/2, imgInimigo:getHeight()/2)
            end
            -- Explosão
            for i, _ in ipairs(expInimigo) do
              love.graphics.draw(imgExplosao[expInimigo[i].aExp], expInimigo[i].x, expInimigo[i].y, 0, 1, 1, imgExplosao[expInimigo[i].aExp]:getWidth()/2, imgExplosao[expInimigo[i].aExp]:getHeight()/2)
            end


            --Desenhar asteroides
            for i, asteroide in ipairs(asteroides) do
              love.graphics.draw(imgAsteroide[ast], asteroide.x, asteroide.y, 0, 1, 1, imgNave:getWidth()/2, imgNave:getHeight()/2)
            end
            -- Desenha update tiros
            for i, upTiro in ipairs(upTiros) do
              love.graphics.draw(imgUpTiro, upTiro.x, upTiro.y, 0, 1, 1, imgNave:getWidth()/2, imgNave:getHeight()/2)
            end
            if pausado == true then
              love.graphics.setFont(love.graphics.newFont(fonte1, 30))
              love.graphics.print("Pausado", larguraTela/2 - 60, alturaTela/9, 0, 1, 1)

              if love.keyboard.isDown("escape")then

                love.event.quit()
              end
            end
            -- Pontuçao 
            love.graphics.setFont(love.graphics.newFont(fonte1, 20))
            love.graphics.print(play.." "..pontos, 10, 10)
          end


          if estaVivo then
            --VIDAS 
            love.graphics.print("Vidas: "..vidas, 10, 40)
            if estaVivo and tempoDano <= 0.1  then

              love.graphics.draw(imgNave, nave.posX, nave.posY, 0, 1, 1, imgNave:getWidth()/2, imgNave:getHeight()/2)
           elseif estaVivo and tempoDano <=0.8 then
              love.graphics.draw(imgNaveDano, nave.posX, nave.posY, 0, 1, 1, imgNave:getWidth()/2, imgNave:getHeight()/2)
            end
          elseif gameOver then
            pausado = true
            love.graphics.setColor(255, 255, 255, transparencia)
            love.graphics.draw(imgGameOver, 0, 0)

            love.graphics.setColor(255, 246, 0)
            love.graphics.setFont(love.graphics.newFont(fonte1, 30))
            love.graphics.print("Pontos: ", larguraTela/3, 40, 0, 1, 1)

            --Ranking
            love.graphics.setColor(255, 246, 0)
            love.graphics.setFont(love.graphics.newFont(fonte, 30))
            love.graphics.print("\n"..nomes[0]..":  "..score[0], larguraTela/3, alturaTela/2 + 20, 0, 1, 1)
            love.graphics.print("\n\n"..nomes[1]..":  "..score[1], larguraTela/3, alturaTela/2 + 50, 0, 1, 1)
            love.graphics.print("\n\n\n"..nomes[2]..":  ".. score[2], larguraTela/3, alturaTela/2 + 80, 0, 1, 1)
            love.graphics.print("\n\n\n\n"..nomes[3]..":  ".. score[3], larguraTela/3, alturaTela/2 + 110, 0, 1, 1)
            love.graphics.setColor(255, 255, 255)

            love.graphics.setColor(255, 246, 0)
            love.graphics.print(play.." "..pontos, larguraTela/3, 100)
            love.graphics.setColor(255, 255, 255)

          end
        end
      end 
    end
  end
end





