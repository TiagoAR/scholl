class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|
      t.string :nome
      t.integer :serie
      t.string :turma
      t.string :endereco
      t.float :nota1
      t.float :nota2
      t.float :nota3
      t.float :nota4

      t.timestamps
    end
  end
end
