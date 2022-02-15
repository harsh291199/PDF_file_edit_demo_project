class User < ApplicationRecord
  has_one_attached :file

  def self.user_data(user, f_name, b_name)
    name = f_name.split(" ").join("_")
    $fields={
      'topmostSubform[0].Page1[0].f1_1[0]'=>"#{f_name}",
      'topmostSubform[0].Page1[0].f1_2[0]'=>"#{b_name}"
    };  
    File.open("tmp/pl_files/#{name}.pl", 'w') do |file|
      file.write("$fields={\n")
      $fields.each{ |field, value| file.write("'#{field}'=> '#{value}',\n") }
      file.write("};")
    end

    system("perl public/genfdf.pl tmp/pl_files/#{name}.pl > tmp/fdf_files/#{name}.fdf")
    system("pdftk public/fw9.pdf fill_form tmp/fdf_files/#{name}.fdf output tmp/pdf_files/#{name}.pdf")

    pdf_file = open("tmp/pdf_files/#{name}.pdf")
    user.file.attach(io: pdf_file, filename: "#{name}")

    File.delete(Rails.root.join('tmp', 'fdf_files', "#{name}.fdf"))
    File.delete(Rails.root.join('tmp', 'pl_files', "#{name}.pl"))
  end
end
