class PalletsController < ApplicationController

  def scan
    @cost_centers = ['NJ', 'IL', 'GA', 'TX', 'CO']
    if !$selected_going_to
      $selected_going_to = ' '
    end
    if !$selected_cost_center
      $selected_cost_center = 'NJ'
    end
  end

  def costcenter
    cc = params[:cost_center]
    if cc.blank?
      # must have a cc entered by the user. Should never get here.
      redirect_to pallets_scan_path, notice: 'Please enter Cost Center.'
    else
      # change the selected cost center
      $selected_cost_center = params[:cost_center]
      redirect_to pallets_scan_path, notice: 'Cost Center updated.'
    end
  end

  def barcode
    truck = params[:truck]
    if truck.blank?
      redirect_to pallets_scan_path, notice: 'Please enter Going to.'
      return
    else
      # change the selected going to
      location = Locmsrt.find_by location: truck
      $selected_going_to = truck
      if !location
        # location not found
        redirect_to pallets_scan_path, notice: 'Invalid location.'
        return
      end
    end
    id = params[:barcode]
    pallet = Pallet.find_by id: id
    if pallet.blank?
     redirect_to pallets_scan_path, notice: 'Pallet not found. Please scan again.'
     return
    end
    if pallet.next_location && pallet.next_location.start_with?('TRUCK') && !params[:truck].blank? && params[:truck] != pallet.next_location && params[:cost_center] == pallet.current_cc
      # need to check if next location has already been set and if it matches the scan
      redirect_to pallets_scan_path, notice: 'Truck should be '+pallet.next_location+'.'
      return
    end
    pallet.next_location = $selected_going_to
    pallet.current_location = $selected_going_to
    pallet.current_cc = $selected_cost_center
    if pallet.next_location.start_with?("TRUCK")
      pallet.current_cc = 'INT'
    end
    pallet.save
    redirect_to pallets_scan_path, notice: 'Pallet was successfully updated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def pallets_params
      params.require(:pallet).permit(:origin_cc, :destination_cc, :current_location, :next_location, :vendor_code, :number_of_pallets)
    end
end
