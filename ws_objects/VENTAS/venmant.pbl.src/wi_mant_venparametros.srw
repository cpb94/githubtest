$PBExportHeader$wi_mant_venparametros.srw
$PBExportComments$Mant. parametros ventas.
forward
global type wi_mant_venparametros from wi_mant_ventanas
end type
type gb_1 from groupbox within wi_mant_venparametros
end type
type cb_1 from u_boton within wi_mant_venparametros
end type
type st_2 from statictext within wi_mant_venparametros
end type
type uo_impresora from u_selec_impresoras within wi_mant_venparametros
end type
type gb_2 from groupbox within wi_mant_venparametros
end type
end forward

global type wi_mant_venparametros from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 3643
integer height = 2020
gb_1 gb_1
cb_1 cb_1
st_2 st_2
uo_impresora uo_impresora
gb_2 gb_2
end type
global wi_mant_venparametros wi_mant_venparametros

type variables



end variables

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "venparametros"
 dw_1.Retrieve(sle_valor.Text)
// dw_conf_impr_usuario.Retrieve(sle_valor.Text,nombre_usuario)
 CALL Super::ue_recuperar






end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de parametros ventas"
istr_parametros.s_listado        = "report_venparametros"


//dw_conf_impr_usuario.settransobject(sqlca)
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
   sle_valor.text=istr_parametros.s_argumentos[2]
	IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
     	dw_1.Retrieve(sle_valor.text)
   END IF
END IF

Select impresora_preparacion Into :uo_impresora.sle_impresora.text From ven_usuimpre
Where  empresa = :codigo_empresa
And    usuario = :nombre_usuario;
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)

end on

on wi_mant_venparametros.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_1=create cb_1
this.st_2=create st_2
this.uo_impresora=create uo_impresora
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.uo_impresora
this.Control[iCurrent+5]=this.gb_2
end on

on wi_mant_venparametros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.uo_impresora)
destroy(this.gb_2)
end on

event ue_actualiza_dw;//if dw_conf_impr_usuario.update() = 1 then
	call super::ue_actualiza_dw
//else
//	rollback;
//	messagebox("Atención!!","Se ha producido un error al actualizar la configuracion de las impresoras.")
//end if
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_venparametros
integer x = 18
integer y = 116
integer width = 3602
integer height = 796
string dataobject = "dw_venparametros"
end type

event dw_1::key;dw_1.AcceptText()
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
			 CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES"
 		bus_datawindow = "dw_ayuda_calidades"
		CASE "tarifa"
      bus_titulo     = "VENTANA SELECCION DE TARIFAS "
 		bus_datawindow = "dw_ayuda_ventarifas"
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almacenes"
   CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = "almacen ='" + dw_1.GetItemString(dw_1.GetRow(),"almacen")+"'"
 		bus_datawindow = "dw_ayuda_almubizonas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"almacen")
end event

event dw_1::rbuttondown;dw_1.AcceptText()
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tarifa"
      bus_titulo     = "VENTANA SELECCION DE TARIFAS "
 		bus_datawindow = "dw_ayuda_ventarifas"
	CASE "almacen"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almacenes"
   CASE "zona"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = "almacen ='" + dw_1.GetItemString(dw_1.GetRow(),"almacen")+"'"
 		bus_datawindow = "dw_ayuda_almubizonas"
	 CASE "calidad"
      bus_titulo     = "VENTANA SELECCION DE CALIDADES"
 		bus_datawindow = "dw_ayuda_calidades"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;//Sin gestión documental
//string ruta,fichero,directorio_actual,directorio_imagenes
//long   donde

//Con gestión documental
string ls_imagen,ls_fichero_imagen,extension_fichero_firma,ls_nombre_fir_en_destino
string ls_descripcion_firma,ls_tipo_documento_firma,ls_host_origen_imagen,ls_documento_origen_imagen,ls_usuario_alta_firma
datetime ld_fecha_alta_imagen
boolean lb_flag,lb_rtn

if dwo.name = 'pb_imagen_sello' then
	//Sin gestión documental
//	directorio_actual = f_directorio_activo()
//	directorio_imagenes = "C:\BMP"
//	f_activar_directorio(directorio_imagenes)
//	
//	if GetFileOpenName("Seleccione Imagen",ruta,fichero,"BMP","Bitmaps (*.BMP),*.BMP") = 1 then
//		//Comprobamos si la imagen esta dentro del directorio de imagenes de promocion
//		donde = Pos(Upper(ruta),Upper(directorio_imagenes))
//		
//		if donde = 1 then		
//			//ruta = Right(Upper(ruta),len(ruta) - len(directorio_imagenes))
//			
//			this.object.vgm_imagen_sello[row] = ruta
//			this.setcolumn("vgm_imagen_sello")
//		else
//			messagebox("Atención!!","La imagen debe encontrarse dentro del directorio C:\BMP")	
//		end if
//	end if
//	
//	f_activar_directorio(directorio_actual)
//	directorio_actual = f_directorio_activo()		
	
	//Con gestión documental		
	if GetFileOpenName("Seleccionar Fichero", ls_fichero_imagen,ls_imagen, "DOC", "Graphic Files (*.bmp;*.gif;*.jpg;*.jpeg),*.bmp;*.gif;*.jpg;*.jpeg" ) = 1 then	
		lb_flag = false		
		
		ld_fecha_alta_imagen       = datetime(today(),now())
		
		extension_fichero_firma = f_extension_fichero(ls_fichero_imagen)
		
		ls_nombre_fir_en_destino = right(string(year(date(ld_fecha_alta_imagen)),"0000"),4)
		ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(month(date(ld_fecha_alta_imagen)),"00")
		ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(day(date(ld_fecha_alta_imagen)),"00")
		ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(hour(time(ld_fecha_alta_imagen)),"00")
		ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(minute(time(ld_fecha_alta_imagen)),"00")
		ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(second(time(ld_fecha_alta_imagen)),"00")	
			
		ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + '.' + extension_fichero_firma
			
		ls_imagen      = directorio_gestion_documental+ls_nombre_fir_en_destino
		
		lb_rtn = CopyFileA(ls_fichero_imagen,ls_imagen,lb_flag)
		
		if lb_rtn then
			gethostname (ls_host_origen_imagen,255)
			ls_documento_origen_imagen = ls_fichero_imagen						
			
			this.object.vgm_imagen_sello[row] = ls_imagen
			this.setcolumn("vgm_imagen_sello")
			
			this.modify("p_vgm_imagen_sello.filename='"+ls_imagen+"'")
//			this.object.documento_firma[row] = ls_imagen
//			this.object.host_origen_firma[row] = ls_host_origen_imagen
//			this.object.documento_origen_firma[row] = ls_documento_origen_imagen
		
		else
			messagebox('Atención!','No se ha podido copiar el fichero al directorio destino.')
		end if
	end if				
	
else
	if dwo.name = 'pb_imagen_firma' then
		//Sin gestión documental
//		directorio_actual = f_directorio_activo()
//		directorio_imagenes = "C:\BMP"
//		f_activar_directorio(directorio_imagenes)
//		
//		if GetFileOpenName("Seleccione Imagen",ruta,fichero,"BMP","Bitmaps (*.BMP),*.BMP") = 1 then
//			//Comprobamos si la imagen esta dentro del directorio de imagenes de promocion
//			donde = Pos(Upper(ruta),Upper(directorio_imagenes))
//			
//			if donde = 1 then		
//				//ruta = Right(Upper(ruta),len(ruta) - len(directorio_imagenes))
//				
//				this.object.vgm_imagen_firma[row] = ruta
//				this.setcolumn("vgm_imagen_firma")
//			else
//				messagebox("Atención!!","La imagen debe encontrarse dentro del directorio C:\BMP")	
//			end if
//		end if
//		
//		f_activar_directorio(directorio_actual)
//		directorio_actual = f_directorio_activo()				
		
		//Con gestión documental		
		if GetFileOpenName("Seleccionar Fichero", ls_fichero_imagen,ls_imagen, "DOC", "Graphic Files (*.bmp;*.gif;*.jpg;*.jpeg),*.bmp;*.gif;*.jpg;*.jpeg" ) = 1 then	
			lb_flag = false		
			
			ld_fecha_alta_imagen       = datetime(today(),now())
			
			extension_fichero_firma = f_extension_fichero(ls_fichero_imagen)
			
			ls_nombre_fir_en_destino = right(string(year(date(ld_fecha_alta_imagen)),"0000"),4)
			ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(month(date(ld_fecha_alta_imagen)),"00")
			ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(day(date(ld_fecha_alta_imagen)),"00")
			ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(hour(time(ld_fecha_alta_imagen)),"00")
			ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(minute(time(ld_fecha_alta_imagen)),"00")
			ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + string(second(time(ld_fecha_alta_imagen)),"00")	
				
			ls_nombre_fir_en_destino = ls_nombre_fir_en_destino + '.' + extension_fichero_firma
				
			ls_imagen      = directorio_gestion_documental+ls_nombre_fir_en_destino
			
			lb_rtn = CopyFileA(ls_fichero_imagen,ls_imagen,lb_flag)
			
			if lb_rtn then
				gethostname (ls_host_origen_imagen,255)
				ls_documento_origen_imagen = ls_fichero_imagen						
				
				this.object.vgm_imagen_firma[row] = ls_imagen
				this.setcolumn("vgm_imagen_firma")
				
				this.modify("p_vgm_imagen_firma.filename='"+ls_imagen+"'")
	//			this.object.documento_firma[row] = ls_imagen
	//			this.object.host_origen_firma[row] = ls_host_origen_imagen
	//			this.object.documento_origen_firma[row] = ls_documento_origen_imagen
			
			else
				messagebox('Atención!','No se ha podido copiar el fichero al directorio destino.')
			end if
		end if				
		
		
	end if	
end if
end event

event dw_1::itemchanged;call super::itemchanged;
if dwo.name = 'vgm_imagen_sello' then
	this.modify("p_vgm_imagen_sello.filename='"+data+"'")
else
	if dwo.name = 'vgm_imagen_firma' then
		this.modify("p_vgm_imagen_firma.filename='"+data+"'")	
	end if
end if
end event

event dw_1::retrieveend;call super::retrieveend;
if rowcount = 1 then
	this.modify("p_vgm_imagen_sello.filename='"+this.object.vgm_imagen_sello[1]+"'")
	this.modify("p_vgm_imagen_firma.filename='"+this.object.vgm_imagen_firma[1]+"'")	
else
	this.modify("p_vgm_imagen_sello.filename='C:\Bmp\help.bmp'")
	this.modify("p_vgm_imagen_firma.filename='C:\Bmp\help.bmp'")		
end if
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_venparametros
integer x = 137
integer y = 28
integer width = 283
integer height = 88
string text = "Empresa:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_venparametros
integer x = 2373
integer y = 928
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_venparametros
integer x = 2784
integer y = 928
end type

event cb_borrar::clicked;// no hace nada 

MessageBox("Solo se puede modificar","",Exclamation!, OK!,1)
f_activar_campo(sle_valor)
end event

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_venparametros
integer x = 434
integer y = 24
boolean bringtotop = true
end type

on sle_valor::getfocus;call wi_mant_ventanas`sle_valor::getfocus;ue_titulo   = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow = "dw_ayuda_empresas"
ue_filtro = ""
isle_campo = this
end on

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_venparametros
integer x = 3195
integer y = 928
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_venparametros
end type

type gb_1 from groupbox within wi_mant_venparametros
integer x = 2359
integer y = 892
integer width = 1262
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_1 from u_boton within wi_mant_venparametros
boolean visible = false
integer x = 2162
integer y = 1116
integer height = 92
integer taborder = 0
boolean enabled = false
string text = "&Aceptar"
end type

event clicked;call super::clicked;Integer numero


Select count(*) Into :numero From ven_usuimpre
Where  empresa = :codigo_empresa
And    usuario = :nombre_usuario;
If IsNull(numero) Then numero = 0

IF numero = 0 then
	  INSERT INTO ven_usuimpre  
         ( empresa,   
           usuario,   
           impresora_preparacion )  
  VALUES ( :codigo_empresa,   
           :nombre_usuario,   
           :uo_impresora.sle_impresora.text )  ;

Else
	  UPDATE ven_usuimpre  
     SET impresora_preparacion  = :uo_impresora.sle_impresora.text
   WHERE ( ven_usuimpre.empresa = :codigo_empresa ) AND  
         ( ven_usuimpre.usuario = :nombre_usuario )   ;

END IF
COMMIT;

end event

type st_2 from statictext within wi_mant_venparametros
boolean visible = false
integer x = 73
integer y = 1128
integer width = 699
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Impresora Preparación:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_impresora from u_selec_impresoras within wi_mant_venparametros
boolean visible = false
integer x = 777
integer y = 1116
integer height = 100
boolean enabled = false
end type

event ue_valores;call super::ue_valores;dw_1.Modify("Datawindow.pinter = '" +uo_impresora.sle_impresora.text+"'")
u_selec_impresoras_report = dw_1
end event

on uo_impresora.destroy
call u_selec_impresoras::destroy
end on

type gb_2 from groupbox within wi_mant_venparametros
boolean visible = false
integer x = 23
integer y = 1036
integer width = 2647
integer height = 240
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
end type

