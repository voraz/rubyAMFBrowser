class CompaniesController < ApplicationController
  
  # return all Companies
  def find_all
    respond_to do |format|
      format.amf  { render :amf => Company.find(:all) }
    end
  end
  
  # return a single Company by id
  # expects id in params[0]
  def find_by_id
    respond_to do |format|
      format.amf { render :amf => Company.find(params[0]) }
    end
  end

  # saves new or updates existing Company
  # expect params[0] to be incoming Company
  def save
    respond_to do |format|
      format.amf do
        @company = params[0]

        if @company.save
          render :amf => @company
        else
          render :amf => FaultObject.new(@company.errors.full_messages.join('\n'))
        end
      end
    end
  end

  # destroy a Company
  # expects id in params[0]
  def destroy
    respond_to do |format|
      format.amf do
        @company = Company.find(params[0])
        @company.destroy

        render :amf => true
      end
    end
  end

end
