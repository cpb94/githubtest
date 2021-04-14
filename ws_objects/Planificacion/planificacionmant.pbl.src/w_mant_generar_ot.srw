$PBExportHeader$w_mant_generar_ot.srw
forward
global type w_mant_generar_ot from wi_mvent_con_empresa
end type
type cb_generar from commandbutton within w_mant_generar_ot
end type
type descripcion_art from statictext within w_mant_generar_ot
end type
end forward

global type w_mant_generar_ot from wi_mvent_con_empresa
integer width = 2615
integer height = 920
cb_generar cb_generar
descripcion_art descripcion_art
end type
global w_mant_generar_ot w_mant_generar_ot

type variables
boolean volver_a_descripcion_abr
end variables

on w_mant_generar_ot.create
int iCurrent
call super::create
this.cb_generar=create cb_generar
this.descripcion_art=create descripcion_art
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generar
this.Control[iCurrent+2]=this.descripcion_art
end on

on w_mant_generar_ot.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_generar)
destroy(this.descripcion_art)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_generar.visible = false;
end choose

istr_parametros.s_titulo_ventana = "Generar todas las OT's de un artículo"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)

f_activar_campo(sle_valor)

end event

event ue_recuperar;DataWindowChild ldw_Hijo // David

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "no_tabla"





dw_1.GetChild("version",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa,sle_valor.text)
call super::ue_recuperar



end event

event activate;call super::activate;w_mant_generar_ot = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_generar_ot
integer x = 251
integer width = 1824
integer height = 312
integer taborder = 20
string dataobject = "dw_generar_ot"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_generar_ot
integer x = 110
integer y = 176
integer width = 261
string text = "Codigo:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_generar_ot
boolean visible = false
integer x = 1298
integer y = 312
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_generar_ot
boolean visible = false
integer x = 1294
integer y = 424
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_generar_ot
integer x = 375
integer y = 176
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE ARTICULOS"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

event sle_valor::losefocus;call super::losefocus;string v_descripcion

select descripcion
into :v_descripcion
from articulos
where codigo = :sle_valor.text
and empresa = :codigo_empresa;

descripcion_art.text = v_descripcion






end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_generar_ot
integer x = 2107
integer y = 368
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_generar_ot
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_generar_ot
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_generar_ot
integer x = 18
integer width = 2510
integer height = 80
end type

type cb_generar from commandbutton within w_mant_generar_ot
integer x = 2103
integer y = 476
integer width = 407
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar"
end type

event clicked;date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion, stock_real, stock_sugerido
int v_pedido, v_linped, v_anyo, maximo_orden, plazo_entrega = 21, v_factor
string v_uso, v_operacion, tipooperacion, articulo_linea, v_base, v_formato, v_version = "1", v_lineaprod = "1"
string v_descripcion_formato, sel
integer  k, indice , m
long cantidad_pedido
str_escandallo vector_escandallo[300]
decimal factor_Acumulado = 1
string v_g2, v_reajuste = "N"
integer nivel
int  li_calibre
long ll_lote

nivel = 0

if sle_valor.text = "" then
	messagebox ("Aviso","Es obligatorio introducir un articulo")
	return
end if
if dw_1.object.version[1] = "" or isnull(dw_1.object.version[1]) then
	messagebox ("Aviso","Es obligatorio introducir la version")
	return
end if

dw_1.AcceptText ()

v_lineaprod = "1"


/////////////////////////////////////////////////////////////////////////////


if MessageBox("Atención", "¿Desea generar nuevas OT´s", Exclamation!, YesNo!, 2) = 2 then
	return
else
	articulo_linea = sle_valor.text
	v_version = dw_1.object.version[1]
	v_operacion = '';
	v_pedido = 0
	v_linped = f_numero_linea_pedido_interno()
	v_anyo = year(today())
	v_cantidad = dw_1.object.cantidad[1] 
	setnull(v_f_entrega)
	v_operacion = '';
	
	SELECT uso INTO :v_uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo_linea;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Recorremos recursivamente el árbol del artículo y llamamos a la función generar OT´s para cada nodo
	
	cantidad_pedido = v_cantidad 
	indice = 1
	for m = 1 to 300
		setnull(vector_Escandallo[m].articulo)
		setnull(vector_Escandallo[m].version)
		setnull(vector_Escandallo[m].factor)
		setnull(vector_Escandallo[m].nivel)
	next
	if v_uso = '1' then
		f_escandallo_factores_con_sin_base(vector_Escandallo, articulo_linea, indice, factor_Acumulado, nivel,true)
	else
		f_escandallo_factores_con_sin_base(vector_Escandallo, articulo_linea, indice, factor_Acumulado, nivel,false)		
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
		//if (v_g2 <> "B" and v_g2 <> "Z" and v_g2 <> "N") or (isnull(v_g2)) or  (sle_valor.text = vector_Escandallo[k].articulo ) then //Error. El codigo estadistico no es significativo para saber si es base. Controlado en f_escandallo_factores_con_sin_base y usar funcion ftc_articulo_base()
			if vector_Escandallo[k].factor <> 0 and not isnull(vector_Escandallo[k].factor) then
				v_cantidad = cantidad_pedido / vector_Escandallo[k].factor
			else
				v_cantidad = cantidad_pedido
			end if
			f_generar_ots(vector_Escandallo[k].articulo, v_version, v_operacion, v_pedido, v_linped, &
							  v_anyo, v_cantidad, v_f_entrega, v_reajuste, articulo_linea, vector_Escandallo[k].factor, vector_Escandallo[k].nivel, ll_lote, li_calibre) 
			f_mensaje_proceso("Generando OT's :",K,indice)		
		//end if
	next
	commit using SQLCA;
	// fin del recorrido del árbol
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	
	f_mensaje_proceso("Generando OT's :",i,dw_1.Rowcount())		
end if

messagebox("Aviso", "Generación finalizada")
///////////////////////////////////////////////////////////////////////////





	

end event

type descripcion_art from statictext within w_mant_generar_ot
integer x = 645
integer y = 180
integer width = 1490
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

