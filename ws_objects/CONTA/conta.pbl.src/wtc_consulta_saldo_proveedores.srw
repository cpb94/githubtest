$PBExportHeader$wtc_consulta_saldo_proveedores.srw
forward
global type wtc_consulta_saldo_proveedores from wt_consultas_padre
end type
type st_1 from statictext within wtc_consulta_saldo_proveedores
end type
end forward

global type wtc_consulta_saldo_proveedores from wt_consultas_padre
integer width = 4105
integer height = 3072
string title = "Consulta Albaranes Clientes"
st_1 st_1
end type
global wtc_consulta_saldo_proveedores wtc_consulta_saldo_proveedores

type variables
string sql_inicial
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	if montaje = '' then
		montaje = dw_montaje_filtro.object.filtro[j]
	else
		montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if
return montaje


end function

on wtc_consulta_saldo_proveedores.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on wtc_consulta_saldo_proveedores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial =  "  SELECT venalb.empresa,   "+&
         "venalb.anyo,   "+&
         "venalb.albaran,   "+&
         "venalb.falbaran,   "+&
         "venalb.cliente,   "+&
         "venalb.total_neto,   "+&
         "genter.razon,   "+&
         "total_neto - impdtopp AS total  "+&
"    FROM venalb,   "+&
"         genter  "+&
"   WHERE ( venalb.empresa = genter.empresa ) and  "+&
"         ( venalb.cliente = genter.codigo ) and  "+&
"         ( ( genter.tipoter = 'C' ) AND  "+&
"         ( deposito <> 'S' ) ) AND   "+&
"         		venalb.empresa = '"+codigo_empresa+"' "
			  

end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_saldo_proveedores
integer x = 3401
integer y = 136
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_saldo_proveedores
integer x = 3557
integer y = 136
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_saldo_proveedores
integer width = 3973
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_saldo_proveedores
integer x = 3214
integer y = 136
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)

dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2328
	dw_montaje_filtro.height = 225
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_saldo_proveedores
integer x = 3712
integer y = 136
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_saldo_proveedores
integer x = 3063
integer y = 136
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible
string new_sql, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venalb.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR venalb.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			
		case "Fecha Albarán"
			if cadena_or = '' then
				cadena_or = " venalb.falbaran "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Albarán "+ddlb_operador.text+" "+em_fecha1.text
			end if
			
	end choose
	
	
	// Comprobamos que rellene algo en los objetos de filtro
	crear_filtro = false
	if ddlb_campo.text <> '' and ddlb_operador.text <> '' then
		if dw_filtro.visible then
			if dw_filtro.GetSelectedRow(0) >0 then
				crear_filtro = true
			end if
		end if
		if em_fecha1.visible then
			if not isnull (em_fecha1) and em_fecha1.text <> '' then
				crear_filtro = true
			end if
		end if
		if sle_valor1.visible then
			if sle_valor1.text <> '' then
				crear_filtro = true
			end if
		end if
	
		if lb_lista.visible then
			if lb_lista.selectedindex() <> -1 then
				crear_filtro = true
			end if
		end if
		
	end if
	
	if crear_filtro then
		if cadena_or <> '' then
			cadena_or = " ( "+cadena_or+" ) "
			fila = dw_montaje_filtro.insertrow(0)
			dw_montaje_filtro.object.filtro[fila] = cadena_or
			dw_montaje_filtro.object.linea[fila] = cadena_or_visible
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	filas = dw_datos.retrieve()
	
	em_fecha1.visible = false
	sle_valor1.visible = false
	dw_filtro.visible = false
	pb_buscar.visible = false
	sle_texto.visible = false
	lb_lista.visible = false
	
	sle_texto.text = ''
	
	sle_valor1.text = ''
	dw_filtro.reset()
	ddlb_campo.selectitem(0) 
	ddlb_operador.selectitem(0) 
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
end if



end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_saldo_proveedores
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_saldo_proveedores
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Cliente","Fecha Albarán"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Cliente from genter where empresa = '"+codigo_empresa+"' and tipoter = 'C'"
		
	CASE "Fecha Albarán" 
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = true
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.text = ">"
		
		
END CHOOSE


//Creación del data window de búsqueda
new_syntax = SQLCA.SyntaxFromSQL(consulta, 'Style(Type=Grid)', error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
	// Display errors
	mensaje_error = "Error en la consulta de la búsqueda. Avise al administrador."+error_syntaxfromSQL
ELSE
	// Generate new DataWindow
	dw_filtro.Create(new_syntax, error_create)
	IF Len(error_create) > 0 THEN
		mensaje_error  = "Error en la creación del DW de búsqueda. Avise al administrador."+error_create
	END IF
END IF

//dw_filtro.visible = true
dw_filtro.SetTransObject(SQLCA)
dw_filtro.Retrieve(codigo_empresa)

end event

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_saldo_proveedores
integer y = 512
integer width = 3973
integer height = 2260
integer taborder = 60
string dataobject = "dwtc_consulta_saldo_proveedores"
end type

event dw_datos::clicked;call super::clicked;Datetime ahora 
String pieza, codigo
if row > 0 then
	if dwo.name = "b_fin" then
		ahora = Datetime(Today(), Now())
		pieza = dw_datos.object.modelo_pieza_ticket_pieza[row]
		codigo = dw_datos.object.modelo_pieza_ticket_codigo[row]
		UPDATE modelo_pieza_ticket SET fecha_fin = :ahora WHERE empresa = :codigo_empresa AND pieza = :pieza AND codigo = :codigo; 
		dw_datos.retrieve()
	end if
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_saldo_proveedores
integer x = 3867
integer y = 136
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_saldo_proveedores
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_saldo_proveedores
integer x = 3493
integer y = 20
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_saldo_proveedores
integer x = 1298
integer y = 232
integer width = 1673
integer height = 132
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_saldo_proveedores
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_saldo_proveedores
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_saldo_proveedores
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_saldo_proveedores
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_saldo_proveedores
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type st_1 from statictext within wtc_consulta_saldo_proveedores
integer x = 69
integer y = 2800
integer width = 3319
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 67108864
string text = "* El informe muestra el importe aplicando todos los descuentos existentes (incluido descuento pronto pago)"
boolean focusrectangle = false
end type

