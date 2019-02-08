class ConnectionsController < ApplicationController
    def create
        connection = Connection.new(new_connection_params)
        if connection.save
            redirect_to user_path(params[:connection][:follows])
        else
            redirect_to :root
        end
    end

    def destroy
        Connection.find(params[:id]).destroy
        redirect_to user_path(params[:connection][:follows])
    end

    private
    def new_connection_params
        params.require(:connection).permit(:user_id, :follows)
    end

end