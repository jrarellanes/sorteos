#encoding:utf-8

class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end
  
  def premiados
    @people = Person.where(premiado: true)
    
    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render json: @people }
    end
    
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :ok }
    end
  end
  
  def sorteo
    
    respond_to do |format|
      format.html # sorteo.html.erb
      format.json { render json: 'sorteo' }
    end 
  end
  
  def premiar
    count = Person.where(:activo => true,:premiado => false).count
    if count == 0
      ganador = "No hay más participantes"
    else
      rand = Random.new.rand(1..count)
      people = Person.where(:activo => true,:premiado => false).shuffle
      person = people[rand-1]
      person.update_attribute(:premiado, true)
      ganador = "#{person.num_empleado} #{person.nombre} - #{person.dependencia}"      
    end
    
    respond_to do |format|
      format.html # premiar.html.erb
      format.json { render json: ganador }
    end 
  end
  
  
  def registro    
    respond_to do |format|
      format.html # registrar.html.erb
      format.json { render json: 'registrar' }
    end 
  end
  
  def registrar
    num_empleado = params[:num_empleado]
    @person = Person.find_by_num_empleado(num_empleado)
    if @person.nil?
      @not_found = true
    else
      @person.update_attribute(:activo, true)      
    end
    
    respond_to do |format|
      format.html { render :action => "registro"}
      format.json { render json: ganador }
    end 
  end

  def asistencia
    @people = Person.where("activo = ?", true).paginate(:page => params[:page], :per_page => 100).order("nombre")
  end
  
end