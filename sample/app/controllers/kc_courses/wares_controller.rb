class KcCourses::WaresController < ApplicationController
  def index
    @page_name = "kc_courses_wares"
    kc_courses_wares = KcCourses::Ware.all.map do |kc_courses_ware|
      DataFormer.new(kc_courses_ware)
        .url(:kc_courses_update_url)
        .url(:kc_courses_delete_url)
        .data
    end

    @component_data = {
      kc_courses_wares: kc_courses_wares,
      create_url: kc_courses_wares_path
    }

    render "/react/page"
  end

  def create
    kc_courses_ware = KcCourses::Ware.new kc_courses_ware_params

    save_model(kc_courses_ware, "kc_courses_ware") do |_kc_courses_ware|
      DataFormer.new(_kc_courses_ware)
        .url(:kc_courses_update_url)
        .url(:kc_courses_delete_url)
        .data
    end
  end

  def update
    kc_courses_ware = KcCourses::Ware.find(params[:id])

    update_model(kc_courses_ware, kc_courses_ware_params, "kc_courses_ware") do |_kc_courses_ware|
      DataFormer.new(_kc_courses_ware)
        .url(:kc_courses_update_url)
        .url(:kc_courses_delete_url)
        .data
    end
  end

  def destroy
    kc_courses_ware = KcCourses::Ware.find(params[:id])
    kc_courses_ware.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def kc_courses_ware_params
      params.require(:kc_courses_ware).permit(:name, :views)
    end
end
