$PBExportHeader$w_con_consumo_bases.srw
forward
global type w_con_consumo_bases from w_int_con_empresa
end type
type gb_20 from groupbox within w_con_consumo_bases
end type
type pb_imprimir from upb_imprimir within w_con_consumo_bases
end type
type gb_98 from groupbox within w_con_consumo_bases
end type
type gb_8 from groupbox within w_con_consumo_bases
end type
type gb_1 from groupbox within w_con_consumo_bases
end type
type em_fdesde from u_em_campo within w_con_consumo_bases
end type
type em_fhasta from u_em_campo within w_con_consumo_bases
end type
type gb_3 from groupbox within w_con_consumo_bases
end type
type cb_1 from u_boton within w_con_consumo_bases
end type
type pb_1 from upb_salir within w_con_consumo_bases
end type
type gb_5 from groupbox within w_con_consumo_bases
end type
type uo_articulo from u_em_campo_2 within w_con_consumo_bases
end type
type uo_formato from u_em_campo_2 within w_con_consumo_bases
end type
type cbx_consumo0 from checkbox within w_con_consumo_bases
end type
type uo_molde from u_em_campo_2 within w_con_consumo_bases
end type
type uo_rl from u_em_campo_2 within w_con_consumo_bases
end type
type cb_2 from commandbutton within w_con_consumo_bases
end type
type dw_articulos_encajados_vtas from datawindow within w_con_consumo_bases
end type
type dw_movimientos_base from datawindow within w_con_consumo_bases
end type
type cb_3 from commandbutton within w_con_consumo_bases
end type
type gb_2 from groupbox within w_con_consumo_bases
end type
type dw_1 from datawindow within w_con_consumo_bases
end type
type cb_4 from commandbutton within w_con_consumo_bases
end type
type copia from singlelineedit within w_con_consumo_bases
end type
type uo_familia from u_em_campo_2 within w_con_consumo_bases
end type
type st_mensajes from statictext within w_con_consumo_bases
end type
type ddlb_periodo from dropdownlistbox within w_con_consumo_bases
end type
type gb_21 from groupbox within w_con_consumo_bases
end type
end forward

global type w_con_consumo_bases from w_int_con_empresa
integer x = 27
integer y = 4
integer width = 6784
integer height = 3760
string title = "Consumo de bases"
gb_20 gb_20
pb_imprimir pb_imprimir
gb_98 gb_98
gb_8 gb_8
gb_1 gb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
gb_3 gb_3
cb_1 cb_1
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_formato uo_formato
cbx_consumo0 cbx_consumo0
uo_molde uo_molde
uo_rl uo_rl
cb_2 cb_2
dw_articulos_encajados_vtas dw_articulos_encajados_vtas
dw_movimientos_base dw_movimientos_base
cb_3 cb_3
gb_2 gb_2
dw_1 dw_1
cb_4 cb_4
copia copia
uo_familia uo_familia
st_mensajes st_mensajes
ddlb_periodo ddlb_periodo
gb_21 gb_21
end type
global w_con_consumo_bases w_con_consumo_bases

forward prototypes
public subroutine f_control (datawindow data)
public function integer f_planificar_base ()
end prototypes

public subroutine f_control (datawindow data);string seccion, linea, turno, articulo, formato, molde, rl, cod_articulo, familia
datetime fecha1, fecha2
long i, k
boolean con_mermas
dec coste_mp, coste_fab, piezas, coste

if cbx_consumo0.checked then
	dw_1.DataObject = "dw_con_consumo_bases_0_rutas"
	dw_1.SetTransObject(SQLCA)
else
	dw_1.DataObject = "dw_con_consumo_bases_rutas"
	dw_1.SetTransObject(SQLCA)	
end if

fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))

dw_1.object.st_fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")

if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text
end if

if uo_formato.em_codigo.text = "" or isnull(uo_formato.em_codigo.text) then
	formato = "%"
else
	formato = uo_formato.em_codigo.text
end if

if uo_molde.em_codigo.text = "" or isnull(uo_molde.em_codigo.text) then
	molde = "%"
else
	molde = uo_molde.em_codigo.text
end if

if uo_rl.em_codigo.text = "" or isnull(uo_rl.em_codigo.text) then
	rl = "%"
else
	rl = uo_rl.em_codigo.text
end if

if uo_familia.em_codigo.text = "" or isnull(uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,fecha1, fecha2, articulo, formato, molde, rl, familia)

for i = 1 to dw_1.rowcount()
	if not cbx_consumo0.checked then	
		dw_1.object.sugerido[i] = dw_1.object.piezas[i]
	end if
next


if cbx_consumo0.checked then
	for i = 1 to dw_1.rowcount()
		if dw_1.object.control_existencias[i] <> 0 then
			articulo = string(dw_1.object.art_escandallo_articulo_ant[i])
			con_mermas = true
			coste_mp = 0
			coste_fab = 0
			coste = 0
			f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, con_mermas)	
			piezas = dw_1.object.control_existencias[i]
			coste = ( coste_mp + coste_fab ) * piezas 
			dw_1.object.coste[i] =  coste
		end if
		f_mensaje_proceso ("Calculando Coste", i , dw_1.rowcount())
	next
end if

if cbx_consumo0.checked then
	dw_1.SetRedraw(false)
	dw_1.SetSort('stock D')
	dw_1.Sort()
	dw_1.groupcalc()
	dw_1.SetRedraw(true)
else
end if

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if


	

end subroutine

public function integer f_planificar_base ();date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion
long v_pedido, v_linped, v_anyo, maximo_orden, v_factor
string v_operacion, tipooperacion, articulo, v_base, v_formato, v_version = "1", v_lineaprod = "1", v_reajuste = "N"
string v_descripcion_formato, sel
datawindow DW
str_escandallo vector_escandallo[300]
integer  k, indice , m
string v_g2, v_uso
decimal factor_Acumulado = 1
long cantidad_pedido
time hora_inicio
long segundos, minutos, total_lineas
integer nivel
long z, total_marcados
int  li_calibre
long ll_lote

total_marcados = 0	
for z = 1 to dw_1.rowcount() 
	if dw_1.object.marcado[z] = 'S' then
		total_marcados ++
	end if
next

nivel = 0

hora_inicio = now()
minutos = 0

DW = dw_1
st_mensajes.visible = true

if MessageBox("Atención", "¿Desea generar nuevas OT´s", Exclamation!, YesNo!, 2) = 2 then
	return 1
else
	j = 0	
	for i = 1 to dw_1.Rowcount() 		

		if dw_1.object.marcado[i] = 'S' then   
			j = j + 1
			st_mensajes.text = " Generando ...  "+string(j)+"  de  "+ string (total_marcados)
			articulo = dw_1.object.articulos_codigo[i]
		
			v_pedido = 0
			v_linped = f_numero_linea_pedido_interno()
			v_anyo = year(today())
			
			if dw_1.object.sugerido[i] > 0 and not isnull (dw_1.object.sugerido[i]) then
				v_cantidad = dw_1.object.sugerido[i]
			end if
				
			v_operacion = '';
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// Recorremos recursivamente el árbol del artículo y llamamos a la función generar OT´s para cada nodo
			
			cantidad_pedido = v_cantidad 
			indice = 1
			for m = 1 to 300
				setnull(vector_Escandallo[m].articulo)
				setnull(vector_Escandallo[m].version)
				setnull(vector_Escandallo[m].factor)
			next
			if articulo <> '' and not isnull(articulo) then
				v_uso = ""
				SELECT uso INTO :v_uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo;
				if v_uso = '1' then
					f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, true)		
				else
					f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, false)		
				end if 
				
				ll_lote    = f_contador_lotes("contador_lotes",1) //El segundo parametro es el valor inicial en caso de que no exista el contador
				li_calibre = 5	
				
				for k=1 to indice
					select g2
					into :v_g2
					from art_codestadistico
					where codigo = :vector_Escandallo[k].articulo
					and empresa = :codigo_empresa;
					// Debe permitir que se programen las bases si hay pedido.
					//if (v_g2 <> "B" and v_g2 <> "Z" and v_g2 <> "N") or isnull(v_g2) or (articulo_linea =  vector_Escandallo[k].articulo) then //Error. El codigo estadistico no es significativo para saber si es base. Controlado en f_escandallo_factores_con_sin_base y usar funcion ftc_articulo_base()
						if vector_Escandallo[k].factor <> 0 and not isnull(vector_Escandallo[k].factor) then
							v_cantidad = cantidad_pedido / vector_Escandallo[k].factor
						else
							v_cantidad = cantidad_pedido
						end if
						f_generar_ots(vector_Escandallo[k].articulo, v_version, v_operacion, v_pedido, v_linped, &
										  v_anyo, v_cantidad, v_f_entrega, v_reajuste, articulo, vector_escandallo[k].factor, vector_Escandallo[k].nivel, ll_lote, li_calibre) 
						
					//end if
				next
			end if
			commit using SQLCA;
			// fin del recorrido del árbol
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		//	f_mensaje_proceso("Generando OT's :",i ,  dw_wow.object.total_marcados[i])		
			segundos = secondsafter ( hora_inicio, now())
			minutos =  ( (segundos / i) * (total_lineas - i) ) / 60
	//		w_planificacion_tencer_wide.st_mensajes.text = w_planificacion_tencer_wide.st_mensajes.text + " Quedan "+string(minutos)+ " minutos."
		end if		
	next

//	destroy operaciones
	
//	 w_planificacion_tencer_wide.dw_1.Retrieve(codigo_empresa,"1")
end if

st_mensajes.visible = false






end function

on w_con_consumo_bases.create
int iCurrent
call super::create
this.gb_20=create gb_20
this.pb_imprimir=create pb_imprimir
this.gb_98=create gb_98
this.gb_8=create gb_8
this.gb_1=create gb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.gb_3=create gb_3
this.cb_1=create cb_1
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_formato=create uo_formato
this.cbx_consumo0=create cbx_consumo0
this.uo_molde=create uo_molde
this.uo_rl=create uo_rl
this.cb_2=create cb_2
this.dw_articulos_encajados_vtas=create dw_articulos_encajados_vtas
this.dw_movimientos_base=create dw_movimientos_base
this.cb_3=create cb_3
this.gb_2=create gb_2
this.dw_1=create dw_1
this.cb_4=create cb_4
this.copia=create copia
this.uo_familia=create uo_familia
this.st_mensajes=create st_mensajes
this.ddlb_periodo=create ddlb_periodo
this.gb_21=create gb_21
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_20
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.gb_98
this.Control[iCurrent+4]=this.gb_8
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.em_fdesde
this.Control[iCurrent+7]=this.em_fhasta
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.gb_5
this.Control[iCurrent+12]=this.uo_articulo
this.Control[iCurrent+13]=this.uo_formato
this.Control[iCurrent+14]=this.cbx_consumo0
this.Control[iCurrent+15]=this.uo_molde
this.Control[iCurrent+16]=this.uo_rl
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.dw_articulos_encajados_vtas
this.Control[iCurrent+19]=this.dw_movimientos_base
this.Control[iCurrent+20]=this.cb_3
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.dw_1
this.Control[iCurrent+23]=this.cb_4
this.Control[iCurrent+24]=this.copia
this.Control[iCurrent+25]=this.uo_familia
this.Control[iCurrent+26]=this.st_mensajes
this.Control[iCurrent+27]=this.ddlb_periodo
this.Control[iCurrent+28]=this.gb_21
end on

on w_con_consumo_bases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_20)
destroy(this.pb_imprimir)
destroy(this.gb_98)
destroy(this.gb_8)
destroy(this.gb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.gb_3)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_formato)
destroy(this.cbx_consumo0)
destroy(this.uo_molde)
destroy(this.uo_rl)
destroy(this.cb_2)
destroy(this.dw_articulos_encajados_vtas)
destroy(this.dw_movimientos_base)
destroy(this.cb_3)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.copia)
destroy(this.uo_familia)
destroy(this.st_mensajes)
destroy(this.ddlb_periodo)
destroy(this.gb_21)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Consumo de Bases"
istr_parametros.s_listado        =   "dw_con_prodpartes_ot"
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
em_fdesde.text = string(RelativeDate(today(), - 90),"dd-mm-yy")
ddlb_periodo.text = "3 Meses"

dw_1.SetTransObject(SQLCA)
dw_movimientos_base.SetTransObject(SQLCA)
dw_articulos_encajados_vtas.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)




end event

event ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_consumo_bases
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_consumo_bases
integer x = 4110
integer y = 264
integer width = 320
integer height = 2028
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_consumo_bases
integer x = 37
integer width = 6647
integer textsize = -8
end type

type gb_20 from groupbox within w_con_consumo_bases
integer x = 5102
integer y = 80
integer width = 1367
integer height = 148
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
end type

type pb_imprimir from upb_imprimir within w_con_consumo_bases
event clicked pbm_bnclicked
integer x = 6469
integer y = 120
integer taborder = 0
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type gb_98 from groupbox within w_con_consumo_bases
integer x = 2839
integer y = 76
integer width = 311
integer height = 152
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Molde"
end type

type gb_8 from groupbox within w_con_consumo_bases
integer x = 3735
integer y = 76
integer width = 411
integer height = 152
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_consumo_bases
integer x = 2066
integer y = 76
integer width = 768
integer height = 152
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type em_fdesde from u_em_campo within w_con_consumo_bases
integer x = 2085
integer y = 132
integer width = 366
integer height = 76
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_consumo_bases
integer x = 2459
integer y = 132
integer width = 366
integer height = 76
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type gb_3 from groupbox within w_con_consumo_bases
integer x = 1161
integer y = 76
integer width = 421
integer height = 152
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Formato"
end type

type cb_1 from u_boton within w_con_consumo_bases
integer x = 6121
integer y = 120
integer width = 338
integer height = 96
integer taborder = 120
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_consumo_bases
integer x = 6587
integer y = 120
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_con_consumo_bases
integer x = 23
integer y = 76
integer width = 1134
integer height = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Articulo"
end type

type uo_articulo from u_em_campo_2 within w_con_consumo_bases
event destroy ( )
integer x = 46
integer y = 132
integer width = 1083
integer taborder = 50
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

type uo_formato from u_em_campo_2 within w_con_consumo_bases
event destroy ( )
integer x = 1179
integer y = 136
integer width = 384
integer height = 76
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

IF Trim(uo_formato.em_campo.text)="" THEN 
 	IF Trim(uo_formato.em_codigo.text)<>"" Then 
		uo_formato.em_campo.SetFocus()
	END IF
 	uo_formato.em_campo.text=""
 	uo_formato.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de formatos"
ue_datawindow = "dw_ayuda_formatos"
ue_filtro     = ""

end event

type cbx_consumo0 from checkbox within w_con_consumo_bases
integer x = 3753
integer y = 140
integer width = 375
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Consumo 0"
boolean lefttext = true
end type

type uo_molde from u_em_campo_2 within w_con_consumo_bases
event destroy ( )
integer x = 2857
integer y = 136
integer width = 274
integer height = 76
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_molde.destroy
call u_em_campo_2::destroy
end on

event modificado;string molde

select descripcion
into :molde
from prodmoldes
where empresa = :codigo_empresa
and codigo = :uo_molde.em_codigo.text;

uo_molde.em_campo.text = molde

IF Trim(uo_molde.em_campo.text)="" THEN 
 	IF Trim(uo_molde.em_codigo.text)<>"" Then 
		uo_molde.em_campo.SetFocus()
	END IF
 	uo_molde.em_campo.text=""
 	uo_molde.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Moldes"
ue_datawindow = "dw_ayuda_prodmoldes"
ue_filtro     = ""

end event

type uo_rl from u_em_campo_2 within w_con_consumo_bases
event destroy ( )
integer x = 3163
integer y = 132
integer width = 123
integer height = 80
integer taborder = 130
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_rl.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_rl.em_codigo.text

select descripcion_abr
into :descripcion
from art_tipomoldura
where empresa = :codigo_empresa
and codigo = :codigo;

uo_rl.em_campo.text = descripcion
IF Trim(uo_rl.em_campo.text)="" THEN 
 IF Trim(uo_rl.em_codigo.text)<>"" Then uo_rl.em_campo.SetFocus()
 uo_rl.em_campo.text=""
 uo_rl.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Relieve"
ue_datawindow = "dw_ayuda_art_tipomoldura"
ue_filtro     = ""

end event

type cb_2 from commandbutton within w_con_consumo_bases
integer x = 5509
integer y = 120
integer width = 530
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostras encajados"
end type

event clicked;string v_articulo, art_encajado, sel
long i, k, ventas
string encajados[], lista_encajados
datastore datos
string codigo, descripcion, formato


dw_articulos_encajados_vtas.reset()

v_articulo = string(dw_1.object.art_escandallo_articulo_ant[dw_1.getrow()])

f_busca_encajados (v_articulo,  encajados)


if upperbound(encajados) = 0 then
	encajados[1] = v_articulo
else
	lista_encajados = encajados[1]
	for i = 2 to upperbound(encajados)
		lista_encajados = lista_encajados +", "+ encajados[i]
	next
end if

//datos.reset()
sel = " SELECT articulos.codigo,  articulos.descripcion, formatos.abreviado  "+&
    	" FROM articulos, formatos  "+&
   	" WHERE ( articulos.empresa = formatos.empresa ) and  "+&
      "   	  ( articulos.formato = formatos.codigo ) and  "+&
      "   	  ( ( articulos.empresa = "+codigo_empresa+" ) AND  "+&
      "   	  ( articulos.codigo in ("+lista_encajados+") ) AND "+& 
      "       ( articulos.fecha_anulado is null ) )    "
		
f_cargar_cursor_nuevo ( sel, datos)
		
for k = 1 to datos.rowcount()
	codigo = datos.object.articulos_codigo[k]
	descripcion = datos.object.articulos_descripcion[k]
	formato = datos.object.formatos_abreviado[k]
	
	select sum (cantidad) as ventas
	into :ventas
	from venlifac
	where empresa = :codigo_empresa
	and articulo = :codigo
	and ffactura >= :em_fdesde.text
	and ffactura <= :em_fhasta.text;
	
	if isnull (ventas ) then
		ventas = 0
	end if

	dw_articulos_encajados_vtas.object.codigo[k] = codigo
	dw_articulos_encajados_vtas.object.descripcion[k] = descripcion
	dw_articulos_encajados_vtas.object.formato[k] = formato
	dw_articulos_encajados_vtas.object.ventas[k] = ventas
next
dw_articulos_encajados_vtas.SetSort("ventas D")

dw_articulos_encajados_vtas.Sort()

destroy datos

end event

type dw_articulos_encajados_vtas from datawindow within w_con_consumo_bases
integer x = 4704
integer y = 232
integer width = 2016
integer height = 2340
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "dw_articulos_encajados_vtas"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_movimientos_base from datawindow within w_con_consumo_bases
integer x = 4718
integer y = 2604
integer width = 2016
integer height = 912
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "dw_movimientos_base"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_3 from commandbutton within w_con_consumo_bases
integer x = 5111
integer y = 120
integer width = 393
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Movimientos"
end type

event clicked;datetime fecha_menos_7_dias 
string sel, articulo
long k
datastore datos


articulo = dw_1.object.art_escandallo_articulo_ant[dw_1.getrow()]

fecha_menos_7_dias = datetime (RelativeDate ( today(), -7 ))

dw_movimientos_base.reset()
sel = " select fecha_mov, cantidade, cantidads "+&
		" from almacenmovimientos "+&
		" where empresa = '"+codigo_empresa+"' " +&
		" and articulo = '"+articulo+"' " +&
		" and fecha_mov >= '"+string(fecha_menos_7_dias)+"' "+&
		" order by fecha_mov desc"
		
f_cargar_cursor_nuevo (sel, datos)

for k = 1 to datos.rowcount()
	dw_movimientos_base.object.fecha[k] = datos.object.fecha_mov[k]
	dw_movimientos_base.object.entrada[k] = datos.object.cantidade[k]
	dw_movimientos_base.object.salida[k] = datos.object.cantidads[k]
	
next


destroy datos
end event

type gb_2 from groupbox within w_con_consumo_bases
integer x = 3154
integer y = 76
integer width = 155
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "RL"
end type

type dw_1 from datawindow within w_con_consumo_bases
integer x = 32
integer y = 236
integer width = 4658
integer height = 3292
boolean bringtotop = true
string dataobject = "dw_con_consumo_bases_rutas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event clicked;string orden, filtro
long z

filtro = ''
orden = ''
if dw_1.Object.t_datawindow.text = "consumo_0" then
	choose case dwo.name
		case "t_piezas"
				orden = "art_codestadistico_g2 ,control_existencias D"
				filtro = 'not Isnull(control_existencias)'
				dw_1.SetRedraw(false)
				dw_1.Setfilter(filtro)
				dw_1.filter()
				dw_1.SetSort(orden)
				dw_1.Sort()
				dw_1.SetRedraw(true)
		case "t_metros"
				orden = "art_codestadistico_g2 ,metros D"
				filtro = 'not Isnull(metros)'
				dw_1.SetRedraw(false)
				dw_1.Setfilter(filtro)
				dw_1.filter()
				dw_1.SetSort(orden)
				dw_1.Sort()
				dw_1.SetRedraw(true)
		case "t_coste"
				orden = "art_codestadistico_g2 ,coste D"
				filtro = 'not Isnull(coste)'
				dw_1.SetRedraw(false)
				dw_1.Setfilter(filtro)
				dw_1.filter()
				dw_1.SetSort(orden)
				dw_1.Sort()
				dw_1.SetRedraw(true)
		end choose	
	
else
	choose case dwo.name
		case "t_stock"
			orden = "art_codestadistico_b_g2 , existencias D"
			filtro = 'not isnull(existencias) '
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
		case "t_metros"
			orden = "art_codestadistico_b_g2 ,metros D"
			filtro = 'not Isnull(metros)'
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
		case "t_planificado"
			orden = "art_codestadistico_b_g2 ,planificado D"
			filtro = 'not Isnull(planificado)'
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
		case "t_previsto"
			orden = "art_codestadistico_b_g2 ,consumo_programado D"
			filtro = 'not Isnull(consumo_programado)'
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
		case "t_piezas"
			orden = "art_codestadistico_b_g2 , piezas D"
			filtro = 'not Isnull(piezas)'
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
		case "t_existencias"
			orden = "art_codestadistico_b_g2 , existencias D"
			filtro = 'not Isnull(existencias)'
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
		case "t_molde"
			orden = "art_codestadistico_b_g2 , articulos_molde D"
			filtro = 'not Isnull(articulos_molde)'
			dw_1.SetRedraw(false)
			dw_1.Setfilter(filtro)
			dw_1.filter()
			dw_1.SetSort(orden)
			dw_1.Sort()
			dw_1.SetRedraw(true)
	end choose
end if

if dwo.name = 'b_planificar' then
	f_planificar_base()
end if
end event

type cb_4 from commandbutton within w_con_consumo_bases
integer x = 4754
integer y = 124
integer width = 334
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Copiar Fila"
end type

event clicked;Int fila, res
String texto
texto = ""
if dw_1.rowcount() > 1 then
	fila = dw_1.getrow()
	if fila >= 1 then
		//.Copy 
/*
		if not isnull(dw_1.object.art_codestadistico_b_g2[fila]) then
			texto = texto + String(dw_1.object.art_codestadistico_b_g2[fila])
		end if
*/		
		if not isnull(dw_1.object.formatos_abreviado[fila]) then
			texto = texto + " " + String(dw_1.object.formatos_abreviado[fila])
		end if
		if not isnull(dw_1.object.art_escandallo_articulo_ant[fila]) then
			texto = texto + " " + String(dw_1.object.art_escandallo_articulo_ant[fila])
		end if
		if not isnull(dw_1.object.articulos_descripcion[fila]) then
			texto = texto + " " + String(dw_1.object.articulos_descripcion[fila])
		end if
/*
		if not isnull(dw_1.object.piezas[fila]) then
			texto = texto + " " + String(dw_1.object.piezas[fila])
		end if
		if not isnull(dw_1.object.metros[fila]) then
			texto = texto + " " + String(dw_1.object.metros[fila])
		end if
		if not isnull(dw_1.object.existencias[fila]) then
			texto = texto + " " + String(dw_1.object.existencias[fila])
		end if
		if not isnull(dw_1.object.articulos_molde[fila]) then
			texto = texto + " " + String(dw_1.object.articulos_molde[fila])
		end if
		if not isnull(dw_1.object.consumo_programado[fila]) then
			texto = texto + " " + String(dw_1.object.consumo_programado[fila])
		end if
		if not isnull(dw_1.object.stock_menos_consumo[fila]) then
			texto = texto + " " + String(dw_1.object.stock_menos_consumo[fila])
		end if
		if not isnull(dw_1.object.planificado[fila]) then
			texto = texto + " " + String(dw_1.object.planificado[fila])
		end if
*/		
		copia.text = texto
		copia.SelectText (1, Len(copia.text))
		res = copia.copy()
	end if
end if
end event

type copia from singlelineedit within w_con_consumo_bases
boolean visible = false
integer x = 4407
integer y = 124
integer width = 133
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
end type

type uo_familia from u_em_campo_2 within w_con_consumo_bases
event destroy ( )
integer x = 3351
integer y = 128
integer width = 357
integer height = 76
integer taborder = 210
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_familia.em_codigo.text

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :codigo;

uo_familia.em_campo.text = descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
 IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
 uo_familia.em_campo.text=""
 uo_familia.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familia"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type st_mensajes from statictext within w_con_consumo_bases
boolean visible = false
integer x = 55
integer y = 244
integer width = 4631
integer height = 324
boolean bringtotop = true
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_periodo from dropdownlistbox within w_con_consumo_bases
integer x = 1614
integer y = 120
integer width = 425
integer height = 376
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"3 Meses","6 Meses","12 Meses"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case ddlb_periodo.text
	case "3 Meses"	
		em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
		em_fdesde.text = string(RelativeDate(today(), - 90),"dd-mm-yy")
	
	case "6 Meses"	
		em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
		em_fdesde.text = string(RelativeDate(today(), - 180),"dd-mm-yy")
	case "12 Meses"	
		em_fhasta.text = string(RelativeDate(today(), - 1),"dd-mm-yy")
		em_fdesde.text = string(RelativeDate(today(), - 365),"dd-mm-yy")
end choose


end event

type gb_21 from groupbox within w_con_consumo_bases
integer x = 3319
integer y = 76
integer width = 411
integer height = 152
integer taborder = 290
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Familia"
end type

