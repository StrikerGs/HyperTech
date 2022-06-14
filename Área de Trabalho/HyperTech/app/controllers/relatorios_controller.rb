class RelatoriosController < ApplicationController

    def report

        respond_to do |format|
            @users = User.all
            format.html
            format.pdf do
              render pdf: "file_name",template: "relatorios/report", formats: [:html]   # Excluding ".pdf" extension.
            end
          end

        @users = User.all
    end

end