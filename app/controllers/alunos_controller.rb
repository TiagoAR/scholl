class AlunosController < ApplicationController
  before_action :set_aluno, only: [:show, :edit, :update, :destroy,:sheet]
  helper_method :situacaoAluno
  helper_method :media
  helper_method :mediaSubstituta
	
  
  # GET /alunos
  # GET /alunos.json
  def index
    @alunos = Aluno.all
  end

  # GET /alunos/1
  # GET /alunos/1.json
  def show
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
  end

  # GET /alunos/1/edit
  def edit
  end

  # GET /alunos/sheet/1
  def sheet
  end

  # GET /alunos/review
  def review
    @alunos = Aluno.all
  end

  def pdf
        @alunos = Aluno.all
	@html = render_to_string(:action => :review, :id=>1)
	@kit = PDFKit.new(@html) 
	send_data(
     		 @kit.to_pdf,
      		:filename => "relatorio.pdf",
      		:type => 'application/pdf',
      		:disposition => "inline")
    return
  end

  # POST /alunos
  # POST /alunos.json
  def create
    @aluno = Aluno.new(aluno_params)

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to @aluno, notice: 'Aluno was successfully created.' }
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alunos/1
  # PATCH/PUT /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(aluno_params)
        format.html { redirect_to @aluno, notice: 'Aluno was successfully updated.' }
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1
  # DELETE /alunos/1.json
  def destroy
    @aluno.destroy
    respond_to do |format|
      format.html { redirect_to alunos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aluno_params
      params.require(:aluno).permit(:nome, :serie, :turma, :endereco, :nota1, :nota2, :nota3, :nota4)
    end

    def media(aluno)
      if aluno.nota1 == nil
        aluno.nota1 = 0
      end
      if aluno.nota2 == nil
        aluno.nota2 = 0
      end
      if aluno.nota3 == nil
        aluno.nota3 = 0
      end
      if aluno.nota4 == nil
        aluno.nota4 = 0
      end
	
		(aluno.nota1 + aluno.nota2 + aluno.nota3 
                + aluno.nota4)/4

    end

    def situacaoAluno(aluno)
	@media = media(aluno)
	if @media >= 7
		"Aprovado"
        elsif mediaSubstituta(aluno) >= 7
              "Recuperacao"    
	else
             "Reprovado"
	end
    end
	
    def mediaSubstituta(aluno)
       @menor = aluno.nota1
       @menorPos = 1	
	if aluno.nota2 < @menor
          @menor = aluno.nota2
          @menorPos = 2
	end
 
       	if aluno.nota3 < @menor
          @menor = aluno.nota3
          @menorPos = 3
	end

	if aluno.nota4 < @menor
          @menor = aluno.nota4
          @menorPos = 4
	end

	if @menorPos == 1
          aluno.nota1 = 100
	end

	if @menorPos == 2
          aluno.nota2 = 100
	end

	if @menorPos == 3
          aluno.nota3 = 100
	end

	if @menorPos == 4
          aluno.nota4 = 100
	end

	media(aluno)
    end
end
