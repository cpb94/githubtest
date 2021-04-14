$PBExportHeader$wi_mant_utiprogramas.srw
forward
global type wi_mant_utiprogramas from wi_mvent_con_empresa
end type
type dw_permisos from u_datawindow within wi_mant_utiprogramas
end type
type cb_añadir from commandbutton within wi_mant_utiprogramas
end type
type cb_eliminar from commandbutton within wi_mant_utiprogramas
end type
type r_1 from rectangle within wi_mant_utiprogramas
end type
type r_2 from rectangle within wi_mant_utiprogramas
end type
type st_2 from statictext within wi_mant_utiprogramas
end type
type cb_generar_usuarios from commandbutton within wi_mant_utiprogramas
end type
type sle_usuario from singlelineedit within wi_mant_utiprogramas
end type
type r_3 from rectangle within wi_mant_utiprogramas
end type
end forward

global type wi_mant_utiprogramas from wi_mvent_con_empresa
integer width = 3401
integer height = 2172
dw_permisos dw_permisos
cb_añadir cb_añadir
cb_eliminar cb_eliminar
r_1 r_1
r_2 r_2
st_2 st_2
cb_generar_usuarios cb_generar_usuarios
sle_usuario sle_usuario
r_3 r_3
end type
global wi_mant_utiprogramas wi_mant_utiprogramas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
if longitud>20 then longitud = 20
criterio[2]   =  trim(mid(sle_valor.text,1,20))+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "utiprogramas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)


if (sle_valor.Text <> "") then
	dw_permisos.retrieve(codigo_empresa, sle_valor.text)
	If dw_permisos.GetRow() > 0 Then 
	  dw_permisos.SetRow(1)
	end if
end if

cb_añadir.enabled = true
cb_eliminar.enabled = true
cb_generar_usuarios.enabled = True

CALL Super::ue_recuperar
end event

event open;call super::open;//Mantenimientos con clave alfanumerica
tipo_mantenimiento = "C"

   istr_parametros.s_titulo_ventana = "Mantenimiento de Programas"
	istr_parametros.s_listado        = "report_utiprogramas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	dw_permisos.SetTransObject(SQLCA)

end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"acceso","2")
end event

on wi_mant_utiprogramas.create
int iCurrent
call super::create
this.dw_permisos=create dw_permisos
this.cb_añadir=create cb_añadir
this.cb_eliminar=create cb_eliminar
this.r_1=create r_1
this.r_2=create r_2
this.st_2=create st_2
this.cb_generar_usuarios=create cb_generar_usuarios
this.sle_usuario=create sle_usuario
this.r_3=create r_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_permisos
this.Control[iCurrent+2]=this.cb_añadir
this.Control[iCurrent+3]=this.cb_eliminar
this.Control[iCurrent+4]=this.r_1
this.Control[iCurrent+5]=this.r_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_generar_usuarios
this.Control[iCurrent+8]=this.sle_usuario
this.Control[iCurrent+9]=this.r_3
end on

on wi_mant_utiprogramas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_permisos)
destroy(this.cb_añadir)
destroy(this.cb_eliminar)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.st_2)
destroy(this.cb_generar_usuarios)
destroy(this.sle_usuario)
destroy(this.r_3)
end on

event ue_activa_claves;call super::ue_activa_claves;cb_añadir.enabled = false
cb_eliminar.enabled = false
cb_generar_usuarios.enabled = false

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;cb_añadir.enabled = true
cb_eliminar.enabled = true
cb_generar_usuarios.enabled = True

end event

event ue_actualiza_dw;call super::ue_actualiza_dw;boolean error_actualizando

error_actualizando = false

dw_permisos.setfilter("")
dw_permisos.filter()
if dw_permisos.update() <> 1 then
	error_actualizando = True
end if


if error_actualizando then
	rollback;
end if


end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_utiprogramas
integer x = 9
integer y = 328
integer width = 2327
integer height = 964
string dataobject = "dw_utiprogramas"
borderstyle borderstyle = stylelowered!
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	
	CASE "tipo"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_utitipoprograma"
   CASE "aplicacion"
      bus_titulo     = "VENTANA SELECCION DE APLICAIONES"
  		bus_datawindow = "dw_ayuda_utiaplicaciones"
 	CASE ELSE
		SetNull(bus_campo)

 END CHOOSE
 CALL Super::Key
 
END IF

end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"tipo")
f_valores_numericos(dw_1,"aplicacion")
end on

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "tipo"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_utitipoprograma"
   CASE "aplicacion"
      bus_titulo     = "VENTANA SELECCION DE APLICAIONES"
  		bus_datawindow = "dw_ayuda_utiaplicaciones"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE ls_objeto
  
CASE 'pb_tipo'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo")
   OpenWithParm(wi_mant_utitipoprograma,lstr_param)  
CASE 'pb_aplicacion'
   
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"aplicacion")
   OpenWithParm(wi_mant_utiaplicaciones,lstr_param)  

END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_utiprogramas
integer x = 18
integer y = 192
integer width = 329
string text = "Programa"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_utiprogramas
integer x = 2231
integer y = 184
integer width = 361
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_utiprogramas
integer x = 2597
integer y = 184
integer width = 361
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_utiprogramas
integer x = 347
integer y = 188
integer width = 1810
fontcharset fontcharset = ansi!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_utiprogramas"
   ue_titulo         = "AYUDA SELECCION DE PROGRAMAS"
   ue_filtro         = ""
   isle_campo        = This
	ue_campo = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_utiprogramas
integer x = 2962
integer y = 184
integer width = 361
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_utiprogramas
integer taborder = 50
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_utiprogramas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_utiprogramas
integer x = 27
integer width = 3282
integer height = 84
end type

type dw_permisos from u_datawindow within wi_mant_utiprogramas
integer x = 2359
integer y = 392
integer width = 928
integer height = 1380
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_utipermisos"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;str_parametros lstr_param

dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

If row=0 Then Return

IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
END IF


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = false
CHOOSE CASE bus_campo
	CASE "usuario"
		bus_titulo     = "AYUDA SELECCION usuarios"
		bus_datawindow = "dw_ayuda_usuarios"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = FALSE
CHOOSE CASE bus_campo
	CASE "usuario"
		bus_titulo     = "AYUDA SELECCION USUARIOS"
		bus_datawindow = "dw_ayuda_usuarios"
		bus_filtro     = "" 	
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::key


end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type cb_añadir from commandbutton within wi_mant_utiprogramas
integer x = 2414
integer y = 1804
integer width = 411
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;long fila_actual

if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if

dw_permisos.scrolltorow(dw_permisos.InsertRow(0))
dw_permisos.SetColumn(1)
dw_permisos.Setfocus()

fila_actual = dw_permisos.Getrow()

dw_permisos.object.empresa[fila_actual] = codigo_empresa
dw_permisos.object.programa[fila_actual] = sle_valor.text





end event

type cb_eliminar from commandbutton within wi_mant_utiprogramas
integer x = 2834
integer y = 1804
integer width = 411
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, v_registro

if MessageBox("Atención", nombre_usuario+": ¿Seguro que quieres borrar el registro?", Question!, YesNo!, 2) = 1 then
	if dw_permisos.Rowcount() > 0 then
		fila_actual = dw_permisos.getrow()
		dw_permisos.DeleteRow(fila_actual)

		error_borrando = False
	
		if dw_permisos.Update() = -1 then
			error_borrando = True
		end if
		
		if error_borrando then
			rollback;
		end if
		
		dw_permisos.retrieve(codigo_empresa, sle_valor.text)
		
		if dw_permisos.Rowcount() > 0 then
			dw_permisos.scrolltoRow(fila_actual)
		end if
	end if
end if

end event

type r_1 from rectangle within wi_mant_utiprogramas
integer linethickness = 4
long fillcolor = 8388736
integer x = 2405
integer y = 1792
integer width = 850
integer height = 92
end type

type r_2 from rectangle within wi_mant_utiprogramas
integer linethickness = 4
long fillcolor = 8388736
integer x = 2350
integer y = 324
integer width = 951
integer height = 1464
end type

type st_2 from statictext within wi_mant_utiprogramas
integer x = 2350
integer y = 324
integer width = 951
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Permisos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_generar_usuarios from commandbutton within wi_mant_utiprogramas
integer x = 1015
integer y = 1404
integer width = 507
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Generar Usuario"
end type

event clicked;long fila_actual, indice, total
string sel, codigo, usuario
datastore programas

if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if

sel = " select codigo "+&
		" from utiprogramas "

usuario = sle_usuario.text

f_cargar_cursor_nuevo (sel, programas)

total = programas.Rowcount()

for indice = 1 to total
	codigo = programas.object.codigo[indice]
	insert into utipermisos ( empresa, programa, usuario, permiso) values (:codigo_empresa, :codigo, :usuario, '0') using SQLCA;
	commit using SQLCA;
next


destroy programas




end event

type sle_usuario from singlelineedit within wi_mant_utiprogramas
integer x = 361
integer y = 1392
integer width = 608
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type r_3 from rectangle within wi_mant_utiprogramas
integer linethickness = 4
long fillcolor = 128
integer x = 997
integer y = 1392
integer width = 539
integer height = 92
end type

