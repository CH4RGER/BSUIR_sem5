using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace sem5_pbz_lab2
{
    public partial class MainMenuForm : Form
    {
        private Db db;

        public MainMenuForm()
        {
            InitializeComponent();
            db = new Db();
            DataTable table = new DataTable();
            db.openConnection();
        }

        private void MainMenuForm_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            string query = "SELECT exhibitionhall.name, exhibitionhall.area, exhibitionhall.address, exhibitionhall.phone_number, owner.Name AS 'owner_name' FROM exhibitionhall JOIN owner ON exhibitionhall.OwnerID = owner.ID";

            MySqlDataAdapter adapter = new MySqlDataAdapter(query, db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            MySqlDataAdapter adapter = new MySqlDataAdapter("SELECT * FROM `artist`", db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            MySqlDataAdapter adapter = new MySqlDataAdapter("SELECT exhibitionhall.name, exhibitionhall.area, exhibitionhall.address, exhibitionhall.phone_number, owner.Name AS 'owner_name' FROM exhibitionhall JOIN owner ON exhibitionhall.OwnerID = owner.ID", db.GetConnection());
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }
            
        private void button1_Click(object sender, EventArgs e)
        {
            MySqlDataAdapter adapter = new MySqlDataAdapter("SELECT * FROM `owner`", db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            string query = "SELECT artwork.Name, exhibitionhall.Address FROM exhibitionhall JOIN exhibition ON exhibitionhall.ExhibitionID = exhibition.ID JOIN exhibitionartwork ON exhibition.ID = exhibitionartwork.ExhibitionID JOIN artwork ON artwork.ID = exhibitionartwork.ArtworkID WHERE(exhibition.Start_date <= '2021-11-04' AND exhibition.End_date >= '2020-11-04')";

            MySqlDataAdapter adapter = new MySqlDataAdapter(query, db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            string query = "SELECT exhibitionhall.Name, exhibitionhall.Address, exhibitionhall.Area, owner.Name FROM exhibitionhall JOIN owner ON exhibitionhall.OwnerID = owner.ID WHERE exhibitionhall.Address LIKE '%Минск%'";

            MySqlDataAdapter adapter = new MySqlDataAdapter(query, db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            string query = "SELECT exhibition.Name, exhibition.Start_date, exhibition.End_date, artwork.Name, artwork.Execution, artist.Name, artwork.Date_of_create FROM exhibition JOIN exhibitionartwork ON exhibitionartwork.ExhibitionID = exhibition.ID JOIN artwork ON artwork.ID = exhibitionartwork.ArtworkID JOIN artist ON artist.ID = artwork.ArtistID;";

            MySqlDataAdapter adapter = new MySqlDataAdapter(query, db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }

       /* private void button2_Click_1(object sender, EventArgs e)
        {
            string query = "SELECT exhibitionhall.name, exhibitionhall.area, exhibitionhall.address, exhibitionhall.phone_number, owner.Name AS 'owner_name' FROM exhibitionhall JOIN owner ON exhibitionhall.OwnerID = owner.ID";

            MySqlDataAdapter adapter = new MySqlDataAdapter(query, db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();            
        }*/

        private void button5_Click(object sender, EventArgs e)
        {
            string query = "SELECT artwork.Name, artwork.Execution, artwork.Date_of_create, artwork.Size, artist.Name AS Artist FROM artwork JOIN artist ON artwork.ArtistID = artist.ID";

            MySqlDataAdapter adapter = new MySqlDataAdapter(query, db.GetConnection());
            DataSet ds = new DataSet();

            adapter.Fill(ds);
            var window = new TableWindow(ds, db.GetConnection(), adapter);
            window.Show();
        }
    }
}
