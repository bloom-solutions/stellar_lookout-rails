module StellarLookout
  module Api
    module V1
      class OperationsController < BaseController

        def create
          ward = Ward.find_by!(params[:ward_id])
          correct_signature = CheckSignature.({
            ward: ward,
            headers: request.headers,
            json: params[:body],
          })

          if correct_signature
            @operation = ProcessOperation.(ward: ward, json: params[:body])
            respond_to do |format|
              format.json { render json: @operation.body, status: :created }
            end
          else
            respond_to do |format|
              format.json do
                render json: {status: "Unauthorized"}, status: :unauthorized
              end
            end
          end
        end

      end
    end
  end
end
