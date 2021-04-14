$PBExportHeader$w_con_famfor_deposito.srw
forward
global type w_con_famfor_deposito from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_famfor_deposito
end type
type dw_listado from datawindow within w_con_famfor_deposito
end type
type cb_continuar from u_boton within w_con_famfor_deposito
end type
type pb_3 from upb_imprimir within w_con_famfor_deposito
end type
type gb_5 from groupbox within w_con_famfor_deposito
end type
type dw_articulos from datawindow within w_con_famfor_deposito
end type
type uo_formato from u_em_campo_2 within w_con_famfor_deposito
end type
type st_2 from statictext within w_con_famfor_deposito
end type
type st_1 from statictext within w_con_famfor_deposito
end type
type uo_cliente from u_em_campo_2 within w_con_famfor_deposito
end type
type em_fechadesde from u_em_campo within w_con_famfor_deposito
end type
type em_fechahasta from u_em_campo within w_con_famfor_deposito
end type
type st_3 from statictext within w_con_famfor_deposito
end type
type st_4 from statictext within w_con_famfor_deposito
end type
type st_5 from statictext within w_con_famfor_deposito
end type
type sle_articulo from singlelineedit within w_con_famfor_deposito
end type
end forward

global type w_con_famfor_deposito from w_int_con_empresa
integer x = 695
integer y = 32
integer width = 2363
integer height = 2476
pb_1 pb_1
dw_listado dw_listado
cb_continuar cb_continuar
pb_3 pb_3
gb_5 gb_5
dw_articulos dw_articulos
uo_formato uo_formato
st_2 st_2
st_1 st_1
uo_cliente uo_cliente
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_3 st_3
st_4 st_4
st_5 st_5
sle_articulo sle_articulo
end type
global w_con_famfor_deposito w_con_famfor_deposito

type variables
String modo
boolean desmarcar = false



end variables

forward prototypes
public subroutine f_activar_dw (string arg_modo)
end prototypes

public subroutine f_activar_dw (string arg_modo);modo = arg_modo


end subroutine

event ue_listar;String filtro
dw_report  = dw_articulos
dw_report.SetTransObject(SQLCA)
//dw_report.retrieve(codigo_empresa)

//if trim(uo_cliente.em_codigo.text)<>"" then
//   filtro  = " cliente = '" + uo_cliente.em_codigo.text + "'"
//End if
//
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
CALL Super::ue_listar
end event

event open;call super::open;em_fechadesde.text = "01-01-01"
em_fechahasta.text = string(today(),"dd-mm-yy")
istr_parametros.s_titulo_ventana="Mapa deposito por Cliente"
This.title=istr_parametros.s_titulo_ventana
dw_listado.SetTransObject(SQLCA)
dw_articulos.SetTransObject(SQLCA)
f_activar_campo(uo_cliente.em_campo)



end event

on w_con_famfor_deposito.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.cb_continuar=create cb_continuar
this.pb_3=create pb_3
this.gb_5=create gb_5
this.dw_articulos=create dw_articulos
this.uo_formato=create uo_formato
this.st_2=create st_2
this.st_1=create st_1
this.uo_cliente=create uo_cliente
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.sle_articulo=create sle_articulo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.cb_continuar
this.Control[iCurrent+4]=this.pb_3
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.dw_articulos
this.Control[iCurrent+7]=this.uo_formato
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.em_fechadesde
this.Control[iCurrent+12]=this.em_fechahasta
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.sle_articulo
end on

on w_con_famfor_deposito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.cb_continuar)
destroy(this.pb_3)
destroy(this.gb_5)
destroy(this.dw_articulos)
destroy(this.uo_formato)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_cliente)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_articulo)
end on

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_famfor_deposito
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_famfor_deposito
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_famfor_deposito
integer x = 37
integer y = 8
integer width = 2226
integer height = 80
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_con_famfor_deposito
integer x = 2139
integer y = 116
integer width = 128
integer height = 112
integer taborder = 0
end type

type dw_listado from datawindow within w_con_famfor_deposito
boolean visible = false
integer x = 1742
integer width = 494
integer height = 84
boolean bringtotop = true
string dataobject = "report_con_famfor_deposito"
boolean livescroll = true
end type

type cb_continuar from u_boton within w_con_famfor_deposito
integer x = 1614
integer y = 128
integer width = 366
integer height = 92
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;string formato
date fecha1, fecha2

fecha1 = date(em_fechadesde.text)
fecha2 = date(em_fechahasta.text)

if trim(uo_cliente.em_codigo.text)="" then
	f_activar_campo(uo_cliente.em_campo)
	Return
End if

// Controla si el cliente tiene "S" en la ficha
String variable
SELECT venclientes.deposito  
INTO   :variable
FROM   venclientes  
WHERE  ( venclientes.empresa = :codigo_empresa ) AND  
	  ( venclientes.codigo  = :uo_cliente.em_codigo.text )   ;

if Trim(variable)<>"S" or isnull(variable) then
  MessageBox("Control cliente","No esta marcado como deposito en la ficha cliente",Exclamation!,Ok!,1)
  f_activar_campo(uo_cliente.em_campo)
  Return
End if

if uo_formato.em_codigo.text = "" or isnull(uo_formato.em_codigo.text) then
	formato = '%'
else
	formato = uo_formato.em_codigo.text
end if

string filtro

dw_articulos.setredraw(false)
dw_articulos.setfilter('')
dw_articulos.Filter()

if sle_articulo.text = '' or isnull(sle_articulo.text) then
	filtro = ""
else
	filtro = upper (" articulos_descripcion like '%"+sle_articulo.text+"%'")
end if

dw_articulos.setfilter(filtro)
dw_articulos.Filter()
dw_articulos.setredraw(true)

dw_articulos.Retrieve(codigo_empresa, uo_cliente.em_codigo.text, formato, fecha1, fecha2)

f_activar_campo(uo_cliente.em_campo)


end event

type pb_3 from upb_imprimir within w_con_famfor_deposito
integer x = 2007
integer y = 128
integer width = 101
integer height = 84
integer taborder = 0
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)

end event

type gb_5 from groupbox within w_con_famfor_deposito
integer x = 1989
integer y = 88
integer width = 137
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_articulos from datawindow within w_con_famfor_deposito
integer x = 73
integer y = 436
integer width = 2217
integer height = 1820
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_venarticulos_excluidos_deposito"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;string sel,articulo,cliente,busqueda
long indice,total,donde
datastore deposito

cliente = uo_cliente.em_codigo.text

sel = "select articulo "+&
		"from venarticulosdeposito "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   cliente = '"+cliente+"'"

f_cargar_cursor_nuevo(sel, deposito)

total = deposito.rowcount()
for indice = 1 to total
	
	articulo = deposito.object.articulo[indice]
	
	busqueda = "articulos_codigo = '"+articulo+"'"
	
	donde = this.find(busqueda,1,rowcount)
	
	if donde > 0 then
		this.object.deposito[donde] = "S"
	end if
next

destroy deposito
end event

event itemchanged;string   articulo,cliente,deposito
datetime falta
boolean  bien = true
long cuantos

if dwo.name = 'deposito' then
	deposito = data
	articulo = this.object.articulos_codigo[row]
	cliente  = uo_cliente.em_codigo.text
	falta    = datetime(today())		
	
	if deposito = "S" then
		select count(*)
		into :cuantos
		from venarticulosdeposito
		where  empresa  = :codigo_empresa
		and    cliente  = :cliente
		and    articulo = :articulo;
		
		if cuantos = 0 then
			insert into venarticulosdeposito
				(empresa,			cliente,			articulo,
				 falta,				usuario)
			values
				(:codigo_empresa,	:cliente,		:articulo,
				 :falta,				:nombre_usuario);
			
			if sqlca.sqlcode <> 0 then
				rollback;
				bien = false
				MessageBox("SQL error", SQLCA.SQLErrText)				
			else
				commit;
			end if
		end if
	else
		delete venarticulosdeposito
		where  empresa  = :codigo_empresa
		and    cliente  = :cliente
		and    articulo = :articulo;
		
		if sqlca.sqlcode <> 0 then
			rollback;
			bien = false
			MessageBox("SQL error", SQLCA.SQLErrText)								
		else
			commit;
		end if
	end if
	
	if not(bien) then		
		return 2
	end if
	
end if

/*
string   articulo,cliente,excluido
long     cuantos
datetime falta
boolean  bien = true

if dwo.name = 'excluido' then
	excluido = data
	articulo = this.object.articulos_codigo[row]
	cliente  = uo_cliente.em_codigo.text
	falta    = datetime(today())		
	cuantos = 0
	
	select count(*)
	into   :cuantos
	from   venarticulosexcluidosdeposito
	where  empresa  = :codigo_empresa
	and    articulo = :articulo
	and cliente = :cliente;
	
	if isnull(cuantos) then cuantos = 0
	
	if excluido = "S" then
		if cuantos = 0 then
			insert into venarticulosexcluidosdeposito
				(empresa,			cliente,			articulo,
				 falta,				usuario)
			values
				(:codigo_empresa,	:cliente,		:articulo,
				 :falta,				:nombre_usuario);
			
			if sqlca.sqlcode <> 0 then
				rollback;
				bien = false
				MessageBox("SQL error", SQLCA.SQLErrText)				
			else
				commit;
			end if
		end if
	else
		if cuantos > 0 then
			delete venarticulosexcluidosdeposito
			where  empresa  = :codigo_empresa
			and    cliente  = :cliente
			and    articulo = :articulo;
			
			if sqlca.sqlcode <> 0 then
				rollback;
				bien = false
				MessageBox("SQL error", SQLCA.SQLErrText)								
			else
				commit;
			end if
		end if		
	end if
	
	if not(bien) then		
		return 2
	end if
	
end if

*/
end event

event clicked;long     indice,total
string   deposito
boolean  continuar = true
dwobject campo


if dwo.name = 'cb_marcar' then
	if desmarcar then
		deposito = "S"	
		if messagebox("Confirmación","¿Desea INCLUIR a deposito todos los articulos?",Question!,YesNo!,1) = 2 then
			continuar = false
		end if
	else
		deposito = "N"
		if messagebox("Confirmación","¿Desea QUITAR de deposito todos los articulos?",Question!,YesNo!,1) = 2 then
			continuar = false
		end if		
	end if
	
	if continuar then
		total = this.rowcount()
		campo = dw_articulos.object.deposito
	
		for indice = 1 to total
			 this.event itemchanged(indice,campo,deposito)
			 this.object.deposito[indice] = deposito
		next
	end if	
	desmarcar = not(desmarcar)
end if

end event

type uo_formato from u_em_campo_2 within w_con_famfor_deposito
event destroy ( )
integer x = 279
integer y = 224
integer width = 311
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text = f_nombre_formato_Abr(codigo_empresa,uo_formato.em_codigo.text)

If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

type st_2 from statictext within w_con_famfor_deposito
integer x = 18
integer y = 232
integer width = 256
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Formato:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_famfor_deposito
integer x = 50
integer y = 140
integer width = 224
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_famfor_deposito
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 132
integer width = 1285
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type em_fechadesde from u_em_campo within w_con_famfor_deposito
integer x = 914
integer y = 224
integer width = 302
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_famfor_deposito
integer x = 1285
integer y = 224
integer width = 279
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_3 from statictext within w_con_famfor_deposito
integer x = 1230
integer y = 224
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_famfor_deposito
integer x = 622
integer y = 232
integer width = 279
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Alta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_con_famfor_deposito
integer x = 5
integer y = 332
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_articulo from singlelineedit within w_con_famfor_deposito
integer x = 270
integer y = 328
integer width = 1294
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

