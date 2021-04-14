$PBExportHeader$w_mant_descliente.srw
forward
global type w_mant_descliente from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_descliente
end type
type cb_1 from commandbutton within w_mant_descliente
end type
end forward

global type w_mant_descliente from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2533
integer height = 768
pb_calculadora pb_calculadora
cb_1 cb_1
end type
global w_mant_descliente w_mant_descliente

type variables

end variables

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Clientes"

This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	

	
	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"tipoter",'C')

end event

event ue_recuperar;
// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "genter"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on w_mant_descliente.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_1
end on

on w_mant_descliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_descliente
integer x = 123
integer y = 292
integer width = 2071
integer height = 236
string dataobject = "dw_mant_descliente"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_descliente
integer x = 59
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_descliente
integer x = 983
integer y = 168
integer width = 389
end type

event cb_insertar::clicked;String descrip
IF this.enabled then
	dw_1.accepttext()
	descrip = dw_1.GetItemString(dw_1.GetRow(),"razon")
	
	if IsNull(descrip) or Trim(descrip) = "" then
		f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción del cliente")
		dw_1.SetFocus()
		return
	end if
end if
Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_descliente
integer x = 1394
integer y = 168
integer width = 389
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_descliente
integer x = 334
integer y = 172
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_clientes"
ue_titulo      = "AYUDA SELECCION DE CLIENTES"
ue_filtro      = "tipoter = 'C'"
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_descliente
integer x = 1806
integer y = 168
integer width = 389
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_descliente
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_descliente
integer x = 2373
integer y = 140
integer width = 78
integer height = 56
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_descliente
integer width = 2437
integer textsize = -12
end type

type pb_calculadora from u_calculadora within w_mant_descliente
integer x = 599
integer y = 164
integer taborder = 0
end type

event clicked;Integer registros

IF not(cb_insertar.enabled) THEN
	Select count(*) 
	Into   :registros
	From   genter
	Where  empresa = :codigo_empresa
	and genter.tipoter = 'C';
	IF registros=0 THEN
		sle_valor.text="1"
	ELSE
		Select max(convert(int,codigo)+1)
		Into   :sle_valor.text
		From   genter
		Where  empresa = :codigo_empresa
		and tipoter = 'C';
	END IF
	dw_1.triggerEvent("clicked")
end if
end event

type cb_1 from commandbutton within w_mant_descliente
boolean visible = false
integer x = 1134
integer y = 708
integer width = 1161
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "NO PULSAR BAJO NINGÚN CONCEPTO"
end type

event clicked;string sel, codigo, descripcion, cli_ventas, cliente
datastore datos
long i, nuevo_codigo, total_Regs

sel = " select codigo, descripcion, cli_ventas from descliente "+&
		" where empresa = '"+codigo_empresa+"' "

f_cargar_cursor_nuevo (sel, datos)

codigo = ''
total_Regs = datos.rowcount()
for i = 1 to total_Regs
	codigo = datos.object.codigo[i]
	descripcion = datos.object.descripcion[i]
	cli_ventas = datos.object.cli_ventas[i]
	if isnull(cli_ventas ) then cli_ventas = ''

	if cli_ventas = '' then
		select max(convert(integer, codigo)) + 1
		into :nuevo_codigo
		from genter
		where empresa = '1'
		and tipoter = 'C';
	

		insert genter (empresa, codigo, razon, tipoter) values ('1', :nuevo_codigo, :descripcion, 'C') using SQLCA;
		commit using SQLCA;		
		update descliente set cli_ventas = :nuevo_codigo
		where codigo = :codigo  using SQLCA;	
		commit using SQLCA;
	
	end if
	

	codigo = ''	
	f_mensaje_proceso ("REGS", i , total_Regs)
next


destroy datos

/*****************************************************************************************************************************/
/*****************************************************************************************************************************/
/*****************************************************************************************************************************/

string coleccion, cliente_hist
dec orden

sel = " select empresa, coleccion, orden, cliente from deshistorico "+&
		" where empresa = '"+codigo_empresa+"' "

f_cargar_cursor_nuevo (sel, datos)

total_Regs = datos.rowcount()
for i = 1 to total_Regs
	coleccion = datos.object.coleccion[i]
	orden = datos.object.orden[i]
	cliente_hist = datos.object.cliente[i]

	select cli_ventas
	into :cli_ventas
	from descliente
	where empresa = :codigo_empresa
	and codigo = :cliente_hist;

	update deshistorico set cliente = :cli_ventas
	where empresa = :codigo_empresa
	and coleccion = :coleccion
	and orden = :orden using SQLCA;  
	
	commit using SQLCA;
	
	f_mensaje_proceso ("REGS", i , total_Regs)
next

destroy datos
/*****************************************************************************************************************************/
/*****************************************************************************************************************************/
/*****************************************************************************************************************************/

string cliente_serie


sel = " select empresa, codigo, cliente from desserie "+&
		" where empresa = '"+codigo_empresa+"' "

f_cargar_cursor_nuevo (sel, datos)

total_Regs = datos.rowcount()
for i = 1 to total_Regs
	codigo = datos.object.codigo[i]
	cliente_serie = datos.object.cliente[i]

	select cli_ventas
	into :cli_ventas
	from descliente
	where empresa = :codigo_empresa
	and codigo = :cliente_serie;

	update desserie set cliente = :cli_ventas
	where empresa = :codigo_empresa
	and codigo = :codigo using SQLCA;  
	
	commit using SQLCA;
	
	f_mensaje_proceso ("REGS", i , total_Regs)
next

destroy datos
end event

