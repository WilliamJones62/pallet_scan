class PalletsController < ApplicationController
  before_action :set_lists, only: [:scan]

  def scan
  end

  def nextlocation
    id = params[:barcode]
    pallet = Pallet.find_by id: id.to_i
    if pallet
      pallet.next_location = params[:next_location]
      pallet.current_location = params[:next_location]
      pallet.save
      redirect_to pallets_scan_path, notice: 'Pallet was successfully updated.'
    else
      redirect_to pallets_scan_path, notice: 'Pallet not found. Please scan again.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lists
      if !$locations
        # need to set up global list of locations
        locations = Locmsrt.all
        $locations = []
        locations.each do |l|
          if (l.staging_flag == "1" || l.pack_flag == "1" || l.primary_dock == "1") && !l.location.blank? && !$locations.include?(l.location)
            $locations.push(l.location)
          end
        end
        $locations.sort!
      end
    end

    # Only allow a list of trusted parameters through.
    def pallets_params
      params.require(:pallet).permit(:origin_cc, :destination_cc, :current_location, :next_location, :vendor_code, :number_of_pallets)
    end
end
