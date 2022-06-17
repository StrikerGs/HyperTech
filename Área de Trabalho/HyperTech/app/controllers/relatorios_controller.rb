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

    def reportV

      respond_to do |format|
        @users = User.all.includes([:products])
        format.html
        format.pdf do
          render pdf: "file_name",template: "relatorios/reportV", formats: [:html]   # Excluding ".pdf" extension.
        end
      end

    @users = User.all

    end

    def reportP

      respond_to do |format|
        @products = Product.all
        format.html
        format.pdf do
          render pdf: "file_name",template: "relatorios/reportP", formats: [:html]   # Excluding ".pdf" extension.
        end
      end

      @products = Product.all

    end

end