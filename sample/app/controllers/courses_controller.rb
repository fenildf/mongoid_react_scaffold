class CoursesController < ApplicationController
  def index
    @page_name = "courses"
    courses = KcCourses::Course.all.map do |course|
      DataFormer.new(course)
        .url(:update_url)
        .url(:delete_url)
        .data
    end

    @component_data = {
      courses: courses,
      create_url: courses_path
    }

    render "/react/page"
  end

  def create
    course = KcCourses::Course.new course_params

    save_model(course, "course") do |_course|
      DataFormer.new(_course)
        .url(:update_url)
        .url(:delete_url)
        .data
    end
  end

  def update
    course = KcCourses::Course.find(params[:id])

    update_model(course, course_params, "course") do |_course|
      DataFormer.new(_course)
        .url(:update_url)
        .url(:delete_url)
        .data
    end
  end

  def destroy
    course = KcCourses::Course.find(params[:id])
    course.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def course_params
      params.require(:course).permit(:name, :views)
    end
end
