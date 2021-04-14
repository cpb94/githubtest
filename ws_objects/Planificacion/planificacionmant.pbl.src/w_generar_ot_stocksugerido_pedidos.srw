$PBExportHeader$w_generar_ot_stocksugerido_pedidos.srw
forward
global type w_generar_ot_stocksugerido_pedidos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_generar_ot_stocksugerido_pedidos
end type
type dw_listado from datawindow within w_generar_ot_stocksugerido_pedidos
end type
type pb_imprimir_preli from picturebutton within w_generar_ot_stocksugerido_pedidos
end type
type dw_1 from datawindow within w_generar_ot_stocksugerido_pedidos
end type
type cb_continuar from u_boton within w_generar_ot_stocksugerido_pedidos
end type
type uo_articulo from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
end type
type gb_2 from groupbox within w_generar_ot_stocksugerido_pedidos
end type
type gb_1 from groupbox within w_generar_ot_stocksugerido_pedidos
end type
type gb_4 from groupbox within w_generar_ot_stocksugerido_pedidos
end type
type gb_67 from groupbox within w_generar_ot_stocksugerido_pedidos
end type
type uo_cliente from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
end type
type cb_generar from commandbutton within w_generar_ot_stocksugerido_pedidos
end type
type uo_g4 from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
end type
type uo_tm from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
end type
type st_2 from statictext within w_generar_ot_stocksugerido_pedidos
end type
type st_1 from statictext within w_generar_ot_stocksugerido_pedidos
end type
type sle_ancho1 from singlelineedit within w_generar_ot_stocksugerido_pedidos
end type
type sle_ancho2 from singlelineedit within w_generar_ot_stocksugerido_pedidos
end type
type sle_largo2 from singlelineedit within w_generar_ot_stocksugerido_pedidos
end type
type sle_largo1 from singlelineedit within w_generar_ot_stocksugerido_pedidos
end type
type r_2 from rectangle within w_generar_ot_stocksugerido_pedidos
end type
end forward

global type w_generar_ot_stocksugerido_pedidos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3712
integer height = 3312
pb_2 pb_2
dw_listado dw_listado
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
cb_continuar cb_continuar
uo_articulo uo_articulo
gb_2 gb_2
gb_1 gb_1
gb_4 gb_4
gb_67 gb_67
uo_cliente uo_cliente
cb_generar cb_generar
uo_g4 uo_g4
uo_tm uo_tm
st_2 st_2
st_1 st_1
sle_ancho1 sle_ancho1
sle_ancho2 sle_ancho2
sle_largo2 sle_largo2
sle_largo1 sle_largo1
r_2 r_2
end type
global w_generar_ot_stocksugerido_pedidos w_generar_ot_stocksugerido_pedidos

type variables
String ante_articulo,retrasos,variable
String marcado = "1"
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string cliente, formato, articulo, g4, tm
decimal ancho1, ancho2, largo1, largo2

dw_1.Setredraw(False)

if uo_cliente.em_codigo.text = "" then 
	cliente = "%"
else
	cliente = uo_cliente.em_codigo.text
end if
if uo_articulo.em_codigo.text = "" then 
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if

if uo_g4.em_campo.text = "" then 
	g4 = "%"
else
	g4 = uo_g4.em_campo.text
end if

if uo_tm.em_campo.text = "" then 
	tm = "%"
else
	tm = uo_tm.em_campo.text
end if

ancho1 = dec(sle_ancho1.text)
ancho2 = dec(sle_ancho2.text)
largo1 = dec(sle_largo1.text)
largo2 = dec(sle_largo2.text)
dw_1.Retrieve(codigo_empresa,cliente, articulo, g4, tm, ancho1, ancho2, largo1, largo2)

dw_1.Setredraw(True)



end subroutine

event ue_listar;dw_report = dw_1
CALL Super::ue_listar
end event

event open;call super::open;String mascara

dw_1.SetTransObject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)
This.title = " Introducción Stock Sugerido con Pedido"

//f_activar_campo(uo_articulo)

integer permiso
string des_empresa

sle_ancho1.text = '0'
sle_ancho2.text = '999999'
sle_largo1.text = '0'
sle_largo2.text = '999999'


permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
	case 1
		cb_generar.visible = false
end choose

end event

on w_generar_ot_stocksugerido_pedidos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.cb_continuar=create cb_continuar
this.uo_articulo=create uo_articulo
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_67=create gb_67
this.uo_cliente=create uo_cliente
this.cb_generar=create cb_generar
this.uo_g4=create uo_g4
this.uo_tm=create uo_tm
this.st_2=create st_2
this.st_1=create st_1
this.sle_ancho1=create sle_ancho1
this.sle_ancho2=create sle_ancho2
this.sle_largo2=create sle_largo2
this.sle_largo1=create sle_largo1
this.r_2=create r_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_continuar
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.gb_67
this.Control[iCurrent+11]=this.uo_cliente
this.Control[iCurrent+12]=this.cb_generar
this.Control[iCurrent+13]=this.uo_g4
this.Control[iCurrent+14]=this.uo_tm
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.sle_ancho1
this.Control[iCurrent+18]=this.sle_ancho2
this.Control[iCurrent+19]=this.sle_largo2
this.Control[iCurrent+20]=this.sle_largo1
this.Control[iCurrent+21]=this.r_2
end on

on w_generar_ot_stocksugerido_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.cb_continuar)
destroy(this.uo_articulo)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_67)
destroy(this.uo_cliente)
destroy(this.cb_generar)
destroy(this.uo_g4)
destroy(this.uo_tm)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_ancho1)
destroy(this.sle_ancho2)
destroy(this.sle_largo2)
destroy(this.sle_largo1)
destroy(this.r_2)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event activate;call super::activate;w_generar_ot_stocksugerido_pedidos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_generar_ot_stocksugerido_pedidos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_generar_ot_stocksugerido_pedidos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_generar_ot_stocksugerido_pedidos
integer x = 27
integer y = 20
integer width = 3575
integer height = 84
boolean italic = true
end type

type pb_2 from upb_salir within w_generar_ot_stocksugerido_pedidos
integer x = 3511
integer y = 156
integer width = 110
integer height = 96
integer taborder = 0
end type

type dw_listado from datawindow within w_generar_ot_stocksugerido_pedidos
boolean visible = false
integer x = 526
integer width = 160
integer height = 92
boolean bringtotop = true
string dataobject = "report_con_ubicaciones_bloqueo_promocion"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_generar_ot_stocksugerido_pedidos
integer x = 3401
integer y = 156
integer width = 110
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;PArent.TriggerEvent("ue_listar")
end event

type dw_1 from datawindow within w_generar_ot_stocksugerido_pedidos
integer x = 23
integer y = 276
integer width = 3621
integer height = 2824
string dataobject = "dw_generar_ot_stocksugerido_pedidos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;//IF f_objeto_datawindow(This)= "marcado" Then
//	IF marcado = "1" Then
//		marcado = "0"
//		This.SetFilter("marca= '*'")
//		This.Filter()
//	ELSE
//		This.SetFilter("")
//		This.Reset()
//		marcado = "1"
//		f_control()
//	END IF
//
//END IF
end event

type cb_continuar from u_boton within w_generar_ot_stocksugerido_pedidos
integer x = 2747
integer y = 156
integer width = 320
integer height = 96
integer taborder = 90
fontcharset fontcharset = ansi!
string text = "&Continuar"
end type

event clicked;f_control()
//f_activar_campo(em_1)
end event

type uo_articulo from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
event destroy ( )
integer x = 937
integer y = 168
integer width = 786
integer height = 72
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type gb_2 from groupbox within w_generar_ot_stocksugerido_pedidos
integer x = 1929
integer y = 116
integer width = 169
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "REL"
end type

type gb_1 from groupbox within w_generar_ot_stocksugerido_pedidos
integer x = 1755
integer y = 116
integer width = 169
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "G4"
end type

type gb_4 from groupbox within w_generar_ot_stocksugerido_pedidos
integer x = 32
integer y = 116
integer width = 873
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_67 from groupbox within w_generar_ot_stocksugerido_pedidos
integer x = 914
integer y = 116
integer width = 837
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type uo_cliente from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
event destroy ( )
integer x = 50
integer y = 168
integer width = 837
integer height = 68
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type cb_generar from commandbutton within w_generar_ot_stocksugerido_pedidos
integer x = 3063
integer y = 156
integer width = 320
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar "
end type

event clicked;date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion, stock_real, stock_sugerido
int v_pedido, v_linped, v_anyo, maximo_orden, plazo_entrega = 21, v_factor
string v_operacion, tipooperacion, articulo_linea, v_base, v_formato, v_version = "1", v_lineaprod = "1"
string v_descripcion_formato, sel, art_encajado
integer  k, indice , m
long cantidad_pedido
str_escandallo vector_escandallo[300]
decimal factor_Acumulado = 1
string v_g2, v_reajuste = "N"
long total_ots
integer nivel

nivel = 0

if MessageBox("Atención", "¿Desea generar nuevas OT´s", Exclamation!, YesNo!, 2) = 2 then
	return
else
	for i = 1 to dw_1.Rowcount() 		
		if dw_1.object.marcado[i] = 'S' then

			articulo_linea = dw_1.object.articulos_codigo[i]

			select count(*)
			into :total_ots
			from planificacion
			where empresa = :codigo_empresa
			and cod_articulo = :articulo_linea ;
			
			if isnull(total_ots) then total_ots = 0 
//			messagebox ("", string(total_ots))
			
			if total_ots > 0 then
				messagebox ("Aviso", "El artículo "+articulo_linea+" ya está planificado y no se generará. ")
			else
				select anyo, pedido, linea
				into :v_anyo, :v_pedido, :v_linped
				from venliped 
				where articulo = :articulo_linea;
				
				setnull(v_f_entrega)
				if isnull(dw_1.object.stock_real[i] ) then
					stock_real = 0
				else
					stock_real = dw_1.object.stock_real[i]
				end if
				if isnull(dw_1.object.articulos_stocksugerido[i] ) then
					stock_sugerido = 0
				else
					stock_sugerido = dw_1.object.articulos_stocksugerido[i]
				end if
	
				if isnull(dw_1.object.cantidad_pedido[i] ) then
					cantidad_pedido = 0
				else
					cantidad_pedido = dw_1.object.cantidad_pedido[i]
				end if
	
				v_cantidad =  stock_sugerido + cantidad_pedido - stock_real
				v_operacion = '';
				
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// Recorremos recursivamente el árbol del artículo y llamamos a la función generar OT´s para cada nodo
				
				if v_cantidad > 0 then
					update venliped
					set planificado = "S"
					where venliped.planificado <> "S"
					and venliped.articulo = :articulo_linea
					and empresa = :codigo_empresa;
					
					cantidad_pedido = v_cantidad 
					indice = 1
					for m = 1 to 300
						setnull(vector_Escandallo[m].articulo)
						setnull(vector_Escandallo[m].version)
						setnull(vector_Escandallo[m].factor)
					next
					f_escandallo_factores(vector_Escandallo, articulo_linea, indice, factor_Acumulado, nivel)		
			
					for k=1 to indice
						select g2
						into :v_g2
						from art_codestadistico
						where codigo = :vector_Escandallo[k].articulo
						and empresa = :codigo_empresa;
						// Debe permitir que se programen las bases si hay pedido.
						if (v_g2 <> "B" and v_g2 <> "Z" and v_g2 <> "N") or isnull(v_g2) then
							if vector_Escandallo[k].factor <> 0 and not isnull(vector_Escandallo[k].factor) then
								v_cantidad = cantidad_pedido / vector_Escandallo[k].factor
							else
								v_cantidad = cantidad_pedido
							end if
							f_generar_ots(vector_Escandallo[k].articulo, v_version, v_operacion, v_pedido, v_linped, &
											  v_anyo, v_cantidad, v_f_entrega, v_reajuste, articulo_linea, vector_Escandallo[k].factor, vector_Escandallo[k].nivel,0,0) 
							f_mensaje_proceso("Generando OT's :",K,indice)		
						end if
					next
				end if						
				
			end if


			commit using SQLCA;
		end if
		// fin del recorrido del árbol
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		f_mensaje_proceso("Generando OT's :",i,dw_1.Rowcount())		
	next
end if

messagebox("Aviso", "Generación finalizada")

/*
date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion, stock_real, stock_sugerido, cantidad_pedido
int v_pedido, v_linped, v_anyo, maximo_orden, plazo_entrega = 21, v_factor
string v_operacion, tipooperacion, articulo_linea, v_base, v_formato, v_version = "1", v_lineaprod = "1"
string v_descripcion_formato, sel

if MessageBox("Atención", "¿Desea generar nuevas OT´s", Exclamation!, YesNo!, 2) = 2 then
	return
else
	if dw_1.Rowcount() < 1 then
		messagebox ("Aviso","No hay ningún pedido pendiente de planificar")
	end if
	
	for i = 1 to dw_1.Rowcount() 		
		if dw_1.object.marcado[i] = 'S' then
			articulo_linea = dw_1.object.articulos_codigo[i]
			
			v_version = '1'
			v_operacion = '';
			v_pedido = 0
			v_linped = f_numero_linea_pedido_interno()
			v_anyo = year(today())
			setnull(v_f_entrega)
			
			if isnull(dw_1.object.stock_real[i] ) then
				stock_real = 0
			else
				stock_real = dw_1.object.stock_real[i]
			end if
			if isnull(dw_1.object.articulos_stocksugerido[i] ) then
				stock_sugerido = 0
			else
				stock_sugerido = dw_1.object.articulos_stocksugerido[i]
			end if
			if isnull(dw_1.object.cantidad_pedido[i] ) then
				cantidad_pedido = 0
			else
				cantidad_pedido = dw_1.object.cantidad_pedido[i]
			end if

			v_cantidad =  stock_sugerido + cantidad_pedido - stock_real
			v_operacion = '';
			if v_cantidad > 0 then
				update venliped
				set planificado = "S"
				where venliped.planificado <> "S"
				and venliped.articulo = :articulo_linea
				and empresa = :codigo_empresa;
				
				f_generar_ots(articulo_linea, v_version, v_operacion, v_pedido, v_linped, v_anyo, v_cantidad, v_f_entrega,"N", articulo_linea) 
			end if						
		end if

		f_mensaje_proceso("Generando OT's :",i,dw_1.Rowcount())		
	next
	
	if dw_1.rowcount() <= 0 then
		MessageBox("Atención", "No se ha generado ninguna OT"	)
	else
		MessageBox("Atención", "Ha finalizado el proceso de generación"	)
	end if
end if

*/
end event

type uo_g4 from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
event destroy ( )
integer x = 1774
integer y = 168
integer width = 119
integer height = 72
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g4.destroy
call u_em_campo_2::destroy
end on

event modificado;string g4
select descripcion_abr 
into :g4
from art_grupo4
where empresa = :codigo_empresa
and codigo = :uo_g4.em_codigo.text;

uo_g4.em_campo.text= g4
IF Trim(uo_g4.em_campo.text)="" THEN 
	IF Trim(uo_g4.em_codigo.text)<>"" Then uo_g4.em_campo.SetFocus()
	uo_g4.em_campo.text=""
	uo_g4.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Grupo 4"
ue_datawindow = "dw_ayuda_art_grupo4"
ue_filtro     = ""

end event

type uo_tm from u_em_campo_2 within w_generar_ot_stocksugerido_pedidos
event destroy ( )
integer x = 1952
integer y = 168
integer width = 119
integer height = 72
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tm.destroy
call u_em_campo_2::destroy
end on

event modificado;string tm

select descripcion_abr 
into :tm
from art_tipomoldura
where empresa = :codigo_empresa
and codigo = :uo_tm.em_codigo.text;

uo_tm.em_campo.text= tm
IF Trim(uo_tm.em_campo.text)="" THEN 
	IF Trim(uo_tm.em_codigo.text)<>"" Then uo_tm.em_campo.SetFocus()
	uo_tm.em_campo.text=""
	uo_tm.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipo Relieve"
ue_datawindow = "dw_ayuda_art_tipomoldura"
ue_filtro     = ""

end event

type st_2 from statictext within w_generar_ot_stocksugerido_pedidos
integer x = 2149
integer y = 192
integer width = 178
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Largo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_generar_ot_stocksugerido_pedidos
integer x = 2149
integer y = 128
integer width = 178
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Ancho:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ancho1 from singlelineedit within w_generar_ot_stocksugerido_pedidos
integer x = 2327
integer y = 124
integer width = 183
integer height = 60
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_ancho2 from singlelineedit within w_generar_ot_stocksugerido_pedidos
integer x = 2514
integer y = 124
integer width = 183
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_largo2 from singlelineedit within w_generar_ot_stocksugerido_pedidos
integer x = 2514
integer y = 188
integer width = 183
integer height = 60
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_largo1 from singlelineedit within w_generar_ot_stocksugerido_pedidos
integer x = 2327
integer y = 188
integer width = 183
integer height = 60
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type r_2 from rectangle within w_generar_ot_stocksugerido_pedidos
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 8421376
integer x = 2135
integer y = 112
integer width = 585
integer height = 152
end type

