"""add flight start and end

Revision ID: 3a7bb192fb7f
Revises: 4fd2632b2414
Create Date: 2013-10-12 11:54:03.351766

"""

# revision identifiers, used by Alembic.
revision = '3a7bb192fb7f'
down_revision = '4fd2632b2414'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.add_column('campaign', sa.Column('flight_start', sa.DateTime()))
    op.add_column('campaign', sa.Column('flight_end', sa.DateTime()))

def downgrade():
    op.drop_column('campaign', 'flight_start')
    op.drop_column('campaign', 'flight_end')

