class Aluno < ActiveRecord::Base
  
  def media
    @nota1 = read_attribute(:nota1)
    @nota2 = read_attribute(:nota2)
    @nota3 = read_attribute(:nota3)
    @nota4 = read_attribute(:nota4)
    if @nota1 == nil
      @nota1 = 0
    end
    if @nota2 == nil
      @nota2 = 0
    end
    if @nota3 == nil
      @nota3 = 0
    end
    if @nota4 == nil
      @nota4 = 0
    end
    puts("#{@nome} = #{(@nota1 + @nota2 + @nota3 + @nota4)/4}")
    return (@nota1 + @nota2 + @nota3 + @nota4)/4
    
  end
  
  def situacaoAluno
    @media = media()
    if @media >= 7
    "Aprovado"
    elsif mediaSubstituta() >= 7
              "Recuperacao"    
    else
             "Reprovado"
    end
  end
  
  def mediaSubstituta
    @nota1 = read_attribute(:nota1)
    @nota2 = read_attribute(:nota2)
    @nota3 = read_attribute(:nota3)
    @nota4 = read_attribute(:nota4) 
    
    if @nota1 == nil
      @nota1 = 0
    end
    if @nota2 == nil
      @nota2 = 0
    end
    if @nota3 == nil
      @nota3 = 0
    end
    if @nota4 == nil
      @nota4 = 0
    end
    
    @menor = @nota1
    @menorPos = 1 
    if @nota2 < @menor
      @menor = @nota2
      @menorPos = 2
    end
    
    if @nota3 < @menor
      @menor = @nota3
      @menorPos = 3
    end
    
    if @nota4 < @menor
      @menor = @nota4
      @menorPos = 4
    end
    
    if @menorPos == 1
      @nota1 = 10
    end
    
    if @menorPos == 2
      @nota2 = 10
    end
    
    if @menorPos == 3
      @nota3 = 10
    end
    
    if @menorPos == 4
      @nota4 = 10
    end
    return (@nota1 + @nota2 + @nota3 + @nota4)/4
  end
  
  
end
