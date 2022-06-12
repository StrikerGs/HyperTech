class RelatoriosController < ApplicationController

    def relatory

        respond_to do |format|
            @users = User.all
            format.html
            format.pdf do
              render pdf: "file_name",template: "relatorios/relatory", formats: [:html], layout: "pdf"   # Excluding ".pdf" extension.
            end
          end

        @users = User.all
    end

end