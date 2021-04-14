$PBExportHeader$w_simulacion_coste.srw
forward
global type w_simulacion_coste from w_int_con_empresa
end type
type pb_1 from upb_salir within w_simulacion_coste
end type
type pb_2 from picturebutton within w_simulacion_coste
end type
type pb_3 from picturebutton within w_simulacion_coste
end type
type pb_4 from picturebutton within w_simulacion_coste
end type
type pb_5 from picturebutton within w_simulacion_coste
end type
type dw_1 from u_datawindow within w_simulacion_coste
end type
type sle_precio from singlelineedit within w_simulacion_coste
end type
type st_1 from statictext within w_simulacion_coste
end type
type cbx_estructural from checkbox within w_simulacion_coste
end type
type gb_1 from groupbox within w_simulacion_coste
end type
type gb_2 from groupbox within w_simulacion_coste
end type
end forward

global type w_simulacion_coste from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 3543
integer height = 2188
pb_1 pb_1
pb_2 pb_2
pb_3 pb_3
pb_4 pb_4
pb_5 pb_5
dw_1 dw_1
sle_precio sle_precio
st_1 st_1
cbx_estructural cbx_estructural
gb_1 gb_1
gb_2 gb_2
end type
global w_simulacion_coste w_simulacion_coste

on w_simulacion_coste.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.pb_3=create pb_3
this.pb_4=create pb_4
this.pb_5=create pb_5
this.dw_1=create dw_1
this.sle_precio=create sle_precio
this.st_1=create st_1
this.cbx_estructural=create cbx_estructural
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.pb_3
this.Control[iCurrent+4]=this.pb_4
this.Control[iCurrent+5]=this.pb_5
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.sle_precio
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cbx_estructural
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
end on

on w_simulacion_coste.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.pb_5)
destroy(this.dw_1)
destroy(this.sle_precio)
destroy(this.st_1)
destroy(this.cbx_estructural)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Simulación Coste"
This.title                       =   istr_parametros.s_titulo_ventana

//f_activar_campo(uo_articulo.em_campo)
end event

event ue_listar;dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_simulacion_coste
integer x = 1861
integer y = 1760
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_simulacion_coste
integer width = 334
end type

event sle_opcion_orden::getfocus;//f_activar_campo(uo_articulo.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_simulacion_coste
integer y = 44
integer width = 1605
integer height = 88
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_simulacion_coste
integer x = 3333
integer y = 44
integer width = 110
integer height = 96
integer taborder = 70
string pointer = ""
boolean originalsize = true
boolean map3dcolors = true
string powertiptext = "Salir"
end type

type pb_2 from picturebutton within w_simulacion_coste
integer x = 3223
integer y = 44
integer width = 110
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Imprimir"
end type

event clicked;f_imprimir_datawindow(dw_1)
//this.triggerEvent("ue_listar")
//f_activar_campo(uo_1.em_campo)
end event

type pb_3 from picturebutton within w_simulacion_coste
integer x = 2962
integer y = 44
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Clear!"
boolean map3dcolors = true
string powertiptext = "Borrar Fila"
end type

event clicked;dw_1.deleterow(dw_1.getrow())
end event

type pb_4 from picturebutton within w_simulacion_coste
integer x = 2853
integer y = 44
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Insert!"
boolean map3dcolors = true
string powertiptext = "Añadir Registro"
end type

event clicked;dw_1.insertrow(0)
end event

type pb_5 from picturebutton within w_simulacion_coste
integer x = 3072
integer y = 44
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Compute5!"
boolean map3dcolors = true
string powertiptext = "Calcular"
end type

event clicked;dec coste_hora, velocidad, correccion_velocidad, factor
dec precio_metro, ancho, largo, coste_estr
long i , cod
string operacion, codigo_coste, formato, coste

for i = 1 to dw_1.rowcount()
	coste = dw_1.object.coste[dw_1.getrow()] 
	coste_hora = dw_1.object.coste_hora[i]
	velocidad =  dw_1.object.velocidad[i]
	correccion_velocidad =  dw_1.object.factor_corrector[i]
	factor = dw_1.object.factor[i]

	dw_1.object.coste_op[i] =  ( coste_hora / ( velocidad * factor * correccion_velocidad ) )  
	
	operacion = dw_1.object.operacion[i]
	codigo_coste = dw_1.object.coste[i]
	select precio_metro
	into :precio_metro
	from factormp
	where empresa = :codigo_empresa
	and operacion = :operacion
	and factor = :codigo_coste;
	
	formato = dw_1.object.formato[i]
	
	select ancho, largo
	into :ancho, :largo
	from formatos
	where empresa = :codigo_empresa
	and codigo = :formato;


	dw_1.object.precio_mp_m2[i] =  precio_metro 
	dw_1.object.coste_mp[i] = ((( ancho * largo) / 10000 ) * precio_metro ) / factor

	if operacion = '' or isnull(operacion) or formato = '' or isnull(formato) or factor = 0 &
		or isnull(factor) or velocidad = 0 or isnull(velocidad) or	coste = '' or isnull(coste) or sle_precio.text = '' then
		messagebox("Atención", "Debe rellenar todos los campos. No continuará el cálculo")
		return;
	end if

next
if cbx_estructural.checked then
	select coste_estructura
	into :coste_estr
	from empresas
	where empresa = :codigo_empresa;
else
	coste_estr = 0
end if

dw_1.object.coste_total[dw_1.rowcount()] = dw_1.object.total_op[dw_1.rowcount()] + dw_1.object.total_mp[dw_1.rowcount()] + coste_estr
dw_1.object.precio[dw_1.rowcount()] = dec(sle_precio.text)
end event

type dw_1 from u_datawindow within w_simulacion_coste
integer x = 18
integer y = 156
integer width = 3433
integer height = 1764
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_simulacion_coste"
boolean vscrollbar = true
boolean border = false
end type

event itemchanged;string  v_factormp, operacion
dec correccion_velocidad, velocidad_std, coste_hora

IF dwo.Name = "operacion" THEN
	dw_1.object.des_operacion[row] = f_buscar_tipooperacion (data)
	select correccion_velocidad, velocidad_std, coste
	into :correccion_velocidad, :velocidad_Std, :coste_hora
	from art_ver_tipooperacion
	where empresa = :codigo_empresa 
	and codigo = :data;
	
	dw_1.object.factor_corrector[row] = correccion_velocidad
	dw_1.object.velocidad[row] = velocidad_std
	dw_1.object.coste_hora[row] = coste_hora

END IF
IF dwo.Name = "formato" THEN
	dw_1.object.des_formato[row] = f_nombre_formato (codigo_empresa,data)

END IF  

IF dwo.Name = "coste" THEN
	operacion = dw_1.object.operacion[row]
	select descripcion
	into :v_factormp
	from factormp
	where empresa = :codigo_empresa
	and operacion = :operacion
	and factor = :data;
	dw_1.object.des_coste[row] = v_factormp  

END IF  

end event

event rbuttondown;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "operacion"
		bus_titulo     = "AYUDA SELECCION TIPOS DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 	
	CASE "formato"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "coste"
		v_operacion = dw_1.object.operacion[dw_1.Getrow()]		
		bus_titulo     = "AYUDA SELECCION FACTOR MP POR OPERACION"
		bus_datawindow = "dw_ayuda_coste_mp_operacion"
		bus_filtro     = " operacion = '"+v_operacion+"' "	
		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event retrieveend;//if this.rowcount() >0 then
//   This.event rowfocuschanged(1)
//end if
//
end event

event key;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "operacion"
		bus_titulo     = "AYUDA SELECCION TIPOS DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 	
	CASE "formato"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "coste"
		v_operacion = dw_1.object.operacion[dw_1.Getrow()]		
		bus_titulo     = "AYUDA SELECCION FACTOR MP POR OPERACION"
		bus_datawindow = "dw_ayuda_coste_mp_operacion"
		bus_filtro     = " operacion = '"+v_operacion+"' "	
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type sle_precio from singlelineedit within w_simulacion_coste
integer x = 2546
integer y = 56
integer width = 247
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type st_1 from statictext within w_simulacion_coste
integer x = 2281
integer y = 56
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Precio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_estructural from checkbox within w_simulacion_coste
integer x = 1678
integer y = 48
integer width = 599
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coste Estructural"
boolean lefttext = true
end type

type gb_1 from groupbox within w_simulacion_coste
integer x = 2830
integer width = 361
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_2 from groupbox within w_simulacion_coste
integer x = 3200
integer width = 251
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 8388608
long backcolor = 12632256
end type

